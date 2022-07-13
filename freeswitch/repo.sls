{% from "freeswitch/map.jinja" import freeswitch with context -%}

/etc/apt/auth.conf:
  file.managed:
    - user: root
    - group: root
    - contents: "machine freeswitch.signalwire.com login signalwire password {{ freeswitch.apt.token }}"
    - mode : 0640

/usr/share/keyrings/signalwire-freeswitch-repo.gpg:
  cmd.run:
    - user: root
    - group: root
    - env:
      - UMASK: 0022
    - name: /usr/bin/wget --http-user=signalwire --http-password={{ freeswitch.apt.token }} -O /usr/share/keyrings/signalwire-freeswitch-repo.gpg https://freeswitch.signalwire.com/repo/deb/debian-release/signalwire-freeswitch-repo.gpg
    - unless: test -e /usr/share/keyrings/signalwire-freeswitch-repo.gpg
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: /usr/share/keyrings/signalwire-freeswitch-repo.gpg
 
freeswitch_repo:
  pkgrepo.managed:
    - humanname: Freeswitch
    - name: deb [signed-by=/usr/share/keyrings/signalwire-freeswitch-repo.gpg] https://freeswitch.signalwire.com/repo/deb/debian-release/ buster main
    - file: /etc/apt/sources.list.d/freeswitch.list
    - clean_file: True
    - gpgcheck: 1
    - require_in:
      - pkg: freeswitch
