# markdown-agda-mode
An Emacs mode for literate Markdown Agda programming.
Adapted directly from a corresponding literate [org Agda mode](https://github.com/alhassy/org-agda-mode).
This allows to edit `.lagda.md` files in Emacs and have both Markdown and Agda highlighting *at the same time*.
In order to load the Agda part, it is necessary to put the cursor within an Agda block of code and hit `C-c C-l`.

![](markdown-agda-example.png)

## requirements

It is necessary to install the following packages:
`polymode`, `poly-markdown`, and `agda2-mode`.

## setup

Copy `markdown-agda-mode.el` to `~/.emacs.d/lisp/`.
Then add the following to `~/.emacs`:

```lisp
;; setup agda mode
(setq auto-mode-alist
   (append
     '(("\\.agda\\'" . agda2-mode)
       ("\\.lagda.md\\'" . agda2-mode))
     auto-mode-alist))

(autoload 'agda2-mode "agda2-mode" "Agda2 mode." t)

;; make sure poly-markdown is installed
(unless (package-installed-p 'polymode) (package-install 'poly-markdown))

;; load markdown-agda-mode
(add-to-list 'load-path "~/.emacs.d/lisp/")
(load "markdown-agda-mode")
```
