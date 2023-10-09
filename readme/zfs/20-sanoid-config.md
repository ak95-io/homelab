# ZFS Sanoid config

```shell
[cheetah]
  use_template = production
  recursive = yes
  process_children_only = yes

[elephant]
  use_template = production
  recursive = yes
  process_children_only = yes

#############################
# templates below this line #
#############################

[template_production]
  frequently = 0
  hourly = 48
  daily = 60
  monthly = 3
  yearly = 0
  autosnap = yes
  autoprune = yes

  hourly_min = 0

  daily_hour = 0
  daily_min = 0

  weekly_wday = 1
  weekly_hour = 0
  weekly_min = 0

  monthly_mday = 1
  monthly_hour = 0
  monthly_min = 0
```
