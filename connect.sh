jack_connect 'PulseAudio JACK Source:front-left' 'SuperCollider:out_1'
jack_connect 'PulseAudio JACK Source:front-right' 'SuperCollider:out_1'
jack_connect 'PulseAudio JACK Source:front-left' 'SuperCollider:out_2'
jack_connect 'PulseAudio JACK Source:front-right' 'SuperCollider:out_2'
jack_connect system:playback_1 SuperCollider:out_1
jack_connect system:playback_1 SuperCollider:out_2
jack_connect system:playback_2 SuperCollider:out_1
jack_connect system:playback_2 SuperCollider:out_2
