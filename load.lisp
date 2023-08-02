(pushnew (uiop:getcwd) ql:*local-project-directories*)
(ql:quickload :sclisp)
(asdf:load-system :sclisp)
