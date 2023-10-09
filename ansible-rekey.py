#!/usr/bin/env python3

# derived from https://stackoverflow.com/a/67161907/277767
# derived from https://gist.github.com/panzi/81892af865a4818e9ccf578ab5766d36

# First of all, add new key to the vault_identity_list in ansible.cfg
# vault_identity_list = old@path1,new@path2
# then, run in the project root.

# Usage:
# > ./ansible-rekey.py decrypt $(grep -R '!vault |' . | cut -d ':' -f1 | uniq)
# > ./ansible-rekey.py <id> $(grep -R '!vault |' . | cut -d ':' -f1 | uniq)

import sys
import re
import os
import json
import hashlib

from typing import Optional
from os.path import join as join_path
from ansible.errors import AnsibleError
from tempfile import gettempdir

VAULT_REGEX = re.compile(r'(?P<prefix>!vault\s+[|>]-?\s*\n)?(?P<vault>^(?P<indent>\s*)\$ANSIBLE_VAULT\S*\n(?:\s*\w+\n)*)', re.MULTILINE)

class ReKeyError(Exception):
    __slots__ = 'lineno', 'cause'

    lineno: int
    cause: Optional[Exception]

    def __init__(self, lineno: int, cause: Optional[Exception]=None) -> None:
        super().__init__()
        self.lineno = lineno
        self.cause = cause

    def __str__(self) -> str:
        return f'at line {self.lineno}: {self.cause if self.cause is not None else "an error occured"}'

def sha1(string: str) -> str:
    return hashlib.sha1(string.encode()).hexdigest()

def rekey(file_name: str, content: str, new_id: str) -> str:
    prev_index = 0
    new_content: list[str] = []
    while True:
        match = VAULT_REGEX.search(content, prev_index)
        if match is None:
            new_content.append(content[prev_index:])
            break

        prefix = match.group('prefix')
        indentation = match.group('indent')
        old_vault = match.group('vault')

        index = match.start()
        if index > prev_index:
            new_content.append(content[prev_index:index])

        string_content = old_vault.replace(indentation, '')
        temp_name = join_path(gettempdir() , f'ansible-rekey-{os.getpid()}-{sha1(file_name)}-{sha1(string_content)}.tmp')

        try:
            with open(temp_name, 'w') as fout:
                fout.write(string_content)

            if not os.path.isfile(temp_name):
                raise Exception("temp file does not exists")

            if new_id == "decrypt":
                os.system(f"ansible-vault decrypt -vvvvv {temp_name}")
                print()
            else:
                os.system(f"ansible-vault rekey -vvvvv --encrypt-vault-id {new_id} {temp_name}")
                print()

            with open(temp_name) as fin:
                lines = fin.readlines()

            if new_id == "decrypt":
                if prefix:
                    new_content.append(json.dumps(''.join(lines)))
                    new_content.append('\n')
                else:
                    new_content.append(indentation)
                    new_content.append(indentation.join(lines))
            else:
                if prefix:
                    new_content.append(prefix)

                new_content.append(indentation)
                new_content.append(indentation.join(lines))
        except Exception as exc:
            lineno = content.count('\n', 0, index) + 1
            if isinstance(exc, AnsibleError):
                exc.message = exc.message.replace(temp_name, f'line {lineno}')
            raise ReKeyError(lineno, exc)
        finally:
            os.remove(temp_name)

        prev_index = match.end()

    return ''.join(new_content)

def rekey_files(new_id: str, files: list[str]) -> None:
    for file_name in files:
        with open(file_name) as f:
            content = f.read()
        try:
            new_content = rekey(file_name, content, new_id)
        except ReKeyError as exc:
            print(f'{file_name}:{exc.lineno}: {exc.cause if exc.cause is not None else "an error occured"}', file=sys.stderr)
        else:
            with open(file_name, 'w') as f:
                f.write(new_content)
            pass

def main() -> None:
    if len(sys.argv) < 2:
        print("Usage: rekey.py <id|decrypt> <file...>", file=sys.stderr)
        sys.exit(1)

    rekey_files(sys.argv[1], sys.argv[2:])

if __name__ == '__main__':
    main()
