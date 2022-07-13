{% from "freeswitch/macros.sls" import dialplan_extension with context %}
{%- from "freeswitch/map.jinja" import freeswitch with context -%}

{% set basedir = '/etc/freeswitch/dialplan' %}

{{ basedir }}:
  file.directory:
    - user: freeswitch
    - group: freeswitch
    - mode: 700


{{ basedir }}/public:
  file.directory:
    - user: freeswitch
    - group: freeswitch
    - mode: 700
    - clean: True
    - require:
      - file: {{ basedir }}

{{ basedir }}/default:
  file.directory:
    - user: freeswitch
    - group: freeswitch
    - mode: 700
    - clean: True
    - require:
      - file: {{ basedir }}


{{ basedir }}/public.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/dialplan/public.xml.jinja
    - require:
      - file: {{ basedir }}
    - onchanges_in:
      - cmd: reload_xml


{{ basedir }}/default.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/dialplan/default.xml.jinja
    - require:
      - file: {{ basedir }}
    - onchanges_in:
      - cmd: reload_xml

{% for context, c_data in freeswitch.get('dialplan', {}).items() %}
{% for extension, e_data in c_data.get('extensions', {}).items() %}
{{ dialplan_extension(extension, context, e_data.condition, e_data.actions, e_data.get('priority', 0)) }}
{% endfor %}
{% endfor %}
