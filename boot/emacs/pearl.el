; This file is used for loading the config.el defined in the Pearl packages.

(defun source-config-file (config-file)
  (setq pkg-name (replace-regexp-in-string "^.*\/packages\/" "" (replace-regexp-in-string "\/pearl-metadata\/.*$" "" config-file)))

  (setenv "PEARL_PKGDIR" (concat pearl-home "packages/" pkg-name))
  (setenv "PEARL_PKGVARDIR" (concat pearl-home "var/" pkg-name))
  (load-file config-file)
  (setenv "PEARL_PKGDIR" nil)
  (setenv "PEARL_PKGVARDIR" nil)
)

(defun pearl-main ()
    (setq pearl-home (file-name-as-directory (getenv "PEARL_HOME")))
    (setq pearl-config-files
      (file-expand-wildcards
        (concat pearl-home
                "packages/*/*/pearl-metadata/config.el"
        )
      )
    )

    (dolist (config-file pearl-config-files)
      (source-config-file config-file)
    )
)

(if (and (getenv "PEARL_HOME") (file-readable-p (getenv "PEARL_HOME"))) (pearl-main) )
