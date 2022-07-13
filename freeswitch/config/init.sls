include:
  - .autoload_configs
  - .dialplan
  - .directory
  - .sip_profiles

/etc/freeswitch:
  file.directory:
    - user: freeswitch
    - group: freeswitch
    - mode: 700

/etc/freeswitch/vars.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/vars.xml.jinja

/etc/freeswitch/modules.conf:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/modules.conf.jinja

/etc/freeswitch/freeswitch.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/freeswitch.xml.jinja

reload_xml:
  cmd.run:
    - name: fs_cli -x 'reloadxml'

{% for rootdir in ['autoload_configs', 'dialplan', 'directory', 'sip_profiles'] %}
root_/etc/freeswitch/{{ rootdir }}:
  file.directory:
    - name: /etc/freeswitch/{{ rootdir }}
    - user: freeswitch
    - group: freeswitch
    - mode: 700
{% endfor %}
