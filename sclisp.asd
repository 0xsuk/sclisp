(asdf:defsystem :sclisp
	:name "sclisp"
	:depends-on (
							 :cl-arrows
							 :cl-collider)
	:serial t
	:components ((:file "package")))
