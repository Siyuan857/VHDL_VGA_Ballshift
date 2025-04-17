# VHDL_VGA_Ballshift

Dieses Projekt befasst sich mit der Realisierung einer einfachen Animation auf einem
VGA-Bildschirm unter Verwendung der Hardwarebeschreibungssprache VHDL. Ziel ist
es: durch den Aufruf der Procedure Circle im externen Paket pack_DrawSign.vhd wird
die Darstellung eines Balls auf einem Bildschirm mit einer Auflösung von 640×480
realisiert. Zusätzlich wird die freie Bewegung des Balls auf dem Bildschirm ermöglicht.
Durch den modularen Einsatz von Generics wird die Darstellung und Bewegung
mehrerer Bälle umgesetzt. Zudem wurde eine Kollisionsabfrage zwischen den Bällen
implementiert.

Zur weiteren Optimierung des Codes wurde das Design so angepasst, dass eine
größere Anzahl von Bällen auch auf Entwicklungsboards mit begrenzten
Hardwareressourcen dargestellt werden kann.
