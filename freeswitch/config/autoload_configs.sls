{% set basedir = '/etc/freeswitch/autoload_configs' %}

{{ basedir }}:
  file.directory:
    - user: freeswitch
    - group: freeswitch
    - mode: 700

{{ basedir }}/acl.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/acl.conf.xml.jinja

{{ basedir }}/cdr_csv.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/cdr_csv.conf.xml.jinja

{{ basedir }}/translate.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/translate.conf.xml.jinja

{{ basedir }}/console.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/console.conf.xml.jinja

{{ basedir }}/db.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/db.conf.xml.jinja

{{ basedir }}/event_socket.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/event_socket.conf.xml.jinja

{{ basedir }}/logfile.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/logfile.conf.xml.jinja

{{ basedir }}/modules.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/modules.conf.xml.jinja

{{ basedir }}/pre_load_modules.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/pre_load_modules.conf.xml.jinja

{{ basedir }}/sofia.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/sofia.conf.xml.jinja

{{ basedir }}/switch.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/switch.conf.xml.jinja

{{ basedir }}/timezones.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/timezones.conf.xml.jinja

{{ basedir }}/xml_rpc.conf.xml:
  file.managed:
    - user: freeswitch
    - group: freeswitch
    - mode: 600
    - template: jinja
    - source: salt://freeswitch/templates/autoload_configs/xml_rpc.conf.xml.jinja
