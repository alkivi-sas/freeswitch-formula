
{%- macro dialplan_group_extension(name, ctx , condition, actions, customer, state='present') -%}
{% set basedir = '/etc/freeswitch/dialplan' %}
{% set filename = name ~ '.xml' %}
{% set group_filename = '100-' ~ customer ~ '.xml' %}
{% if state == 'absent' %}
dialplan_extension_group_{{ ctx }}_{{ name }}:
  file.absent:
    - name: {{ basedir }}/{{ ctx }}/{{ customer }}
    - onchanges_in:
      - cmd: reload_xml
dialplan_extension_{{ ctx }}_{{ name }}:
  file.absent:
    - name: {{ basedir }}/{{ ctx }}/{{ customer }}/{{ filename }}
    - onchanges_in:
      - cmd: reload_xml
dialplan_extension_group_include{{ ctx }}_{{ name }}:
  file.absent:
    - name: {{ basedir }}/{{ ctx }}/{{ group_filename }}
    - onchanges_in:
      - cmd: reload_xml
{% elif state == 'present' %}
dialplan_extension_group_{{ ctx }}_{{ name }}:
  file.directory:
    - name: {{ basedir }}/{{ ctx }}/{{ customer }}
    - user: freeswitch
    - group: freeswitch
    - mode: 700
    - onchanges_in:
      - cmd: reload_xml
    - require:
      - file: /etc/freeswitch/dialplan/{{ ctx }}
dialplan_extension_group_include{{ ctx }}_{{ name }}:
  file.managed:
    - name: {{ basedir }}/{{ ctx }}/{{ group_filename }}
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/dialplan/extension_group.xml.jinja
    - context:
      ctx: {{ ctx }}
      customer: {{ customer }}
    - onchanges_in:
      - cmd: reload_xml
    - require:
      - file: /etc/freeswitch/dialplan/{{ ctx }}
dialplan_extension_{{ ctx }}_{{ name }}:
  file.managed:
    - name: {{ basedir }}/{{ ctx }}/{{ customer }}/{{ filename }}
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/dialplan/extension.xml.jinja
    - context:
      sda: {{ name }}
      condition: {{ condition|tojson }}
      actions: {{ actions|tojson }}
    - require:
      - file: dialplan_extension_group_{{ ctx }}_{{ name }}
      - file: /etc/freeswitch/dialplan/{{ ctx }}
      - file: /etc/freeswitch/dialplan/{{ ctx }}/{{ customer }}
    - onchanges_in:
      - cmd: reload_xml
{% endif %}
{%- endmacro -%}
{%- macro dialplan_extension(name, ctx , condition, actions, priority=0, state='present') -%}
{% set basedir = '/etc/freeswitch/dialplan' %}
{% set prefix = '%03d'|format(priority) %}
{% set filename = prefix ~ '-' ~ name ~ '.xml' %}
{% if state == 'absent' %}
dialplan_extension_{{ ctx }}_{{ name }}:
  file.absent:
    - name: {{ basedir }}/{{ ctx }}/{{ filename }}
    - onchanges_in:
      - cmd: reload_xml
{% elif state == 'present' %}
dialplan_extension_{{ ctx }}_{{ name }}:
  file.managed:
    - name: {{ basedir }}/{{ ctx }}/{{ filename }}
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/dialplan/extension.xml.jinja
    - context:
      sda: {{ name }}
      condition: {{ condition|tojson }}
      actions: {{ actions|tojson }}
    - require:
      - file: {{ basedir }}/{{ ctx }}
      - file: /etc/freeswitch/dialplan/{{ ctx }}
    - onchanges_in:
      - cmd: reload_xml
{% endif %}
{%- endmacro -%}

{%- macro directory_user(name, group, params, variables, state='present') -%}
{% set basedir = '/etc/freeswitch/directory' %}
{% set filename = name ~ '.xml' %}
{% if state == 'absent' %}
directory_user_{{ group }}_{{ name }}:
  file.absent:
    - name: {{ basedir }}/{{ group }}/{{ filename }}
    - onchanges_in:
      - cmd: reload_xml
{% elif state == 'present' %}
directory_user_{{ group }}_{{ name }}:
  file.managed:
    - name: {{ basedir }}/{{ group }}/{{ filename }}
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/directory/user.xml.jinja
    - require:
      - file: {{ basedir }}/{{ group }}
    - onchanges_in:
      - cmd: reload_xml
    - context:
      account: {{ name }}
      params: {{ params|tojson }}
      variables: {{ variables|tojson }}
{% endif %}
{%- endmacro -%}
