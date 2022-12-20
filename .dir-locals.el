;;; .dir-locals.el --- description -*- lexical-binding: t; -*-
;;;
((nil . ((eval . (setq org-roam-directory (concat (shell-command-to-string
                                                   "git rev-parse --show-toplevel | tr -d '\n'")
                                                  "/docs/org")))
         (eval . (setq org-attach-id-dir (concat (shell-command-to-string
                                                  "git rev-parse --show-toplevel | tr -d '\n'")
                                                 "/docs/org/attach/")))
         (eval . (setq org-roam-db-location (concat (shell-command-to-string
                                                     "git rev-parse --show-toplevel | tr -d '\n'")
                                                    "/.cache/org-roam.db")))
         (eval . (setq ein:jupyter-server-notebook-directory (concat (shell-command-to-string
                                                                  "git rev-parse --show-toplevel | tr -d '\n'")
                                                                 "/playground/notebooks")))
         (eval . (setq ein:jupyter-default-notebook-directory (concat (shell-command-to-string
                                                                      "git rev-parse --show-toplevel | tr -d '\n'")
                                                                     "/playground/notebooks")))
         (eval . (setq ein:jupyter-server-command "jupyterEnv"
                       ein:jupyter-default-server-command "jupyterEnv"
                       ))))
 (org-mode . ((org-tanglesync-mode . t)))
 )
;;;docs/org-mode-locals.el ends here
