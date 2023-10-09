# User and permissions helpers

```shell
sudo chown aam:operations -R . && \
find . -type d -exec chmod 775 {} \; && \
find . -type f -exec chmod 664 {} \;

rename 'y/A-Z/a-z/' ./* && \
rename 'y/\ /./' ./* && \
rename 's/(\-|\+)/\./g' ./* && \
rename 's/(\(|\)|\{|\}|\[|\])//g' ./* && \
rename 's/(\.)+/\./g' ./*

rename 's/^/007\./' *.mkv
```
