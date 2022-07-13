{% from "freeswitch/map.jinja" import freeswitch with context -%}

include:
  - .repo

freeswitch:
  pkg.installed:
    - name: {{ freeswitch.pkg }}


