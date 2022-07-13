{% from "freeswitch/macros.sls" import directory_user with context %}
{%- from "freeswitch/map.jinja" import freeswitch with context -%}

{% set basedir = '/etc/freeswitch/directory' %}

{{ basedir }}:
  file.directory:
    - user: freeswitch
    - group: freeswitch
    - mode: 700



{{ basedir }}/default.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/directory/default.xml.jinja
    - require:
      - file: {{ basedir }}
    - onchanges_in:
      - cmd: reload_xml


{% for domain, d_data in freeswitch.get('directory', {}).items() %}
{% for group, g_data in d_data.get('groups', {}).items() %}
{{ basedir }}/{{ group }}:
  file.directory:
    - user: freeswitch
    - group: freeswitch
    - mode: 700
{% for user, u_data in g_data.get('users', {}).items() %}
{{ directory_user(user, group, u_data.params, u_data.variables) }}
{% endfor %}
{% endfor %}
{% endfor %}
