{%- from "freeswitch/map.jinja" import freeswitch with context -%}

{% set basedir = '/etc/freeswitch/sip_profiles' %}

{{ basedir }}:
  file.directory:
    - user: freeswitch
    - group: freeswitch
    - mode: 700

{{ basedir }}/external:
  file.directory:
    - user: freeswitch
    - group: freeswitch
    - mode: 700
    - require:
      - file: {{ basedir }}

{{ basedir }}/internal.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/sip_profiles/internal.xml.jinja
    - require:
      - file: {{ basedir }}
    - onchanges_in:
      - cmd: reload_xml

{{ basedir }}/external.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/sip_profiles/external.xml.jinja
    - require:
      - file: {{ basedir }}
    - onchanges_in:
      - cmd: reload_xml

{% for gateway, data in freeswitch.get('gateways', {})|dictsort %}
{{ basedir }}/external/{{ gateway }}.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/sip_profiles/gateway.xml.jinja
    - context:
    - require:
      - file: {{ basedir }}/external
    - onchanges_in:
      - cmd: reload_xml
      gateway: {{ gateway }}
      params: {{ data['params']|tojson }}
{% endfor %}
