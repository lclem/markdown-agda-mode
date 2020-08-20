;;; markdown-agda-mode.el --- Major mode for working with literate Markdown Agda files
;; Shamelessly adapted from https://github.com/alhassy/org-agda-mode
;;; -*- lexical-binding: t

;;; Commentary:

;; A Major mode for editing Agda code embedded in Markdown files (.lagda.md files.)
;; See the Agda manual for more information:
;; https://agda.readthedocs.io/en/v2.6.1/tools/literate-programming.html#literate-markdown

;;; Code:

(require 'polymode)
(require 'agda2-mode)

(defgroup markdown-agda-mode nil
  "org-agda-mode customisations"
  :group 'languages)

(defcustom use-agda-input t
  "Whether to use Agda input mode in non-Agda parts of the file."
  :group 'markdown-agda-mode
  :type 'boolean)

(define-hostmode poly-markdown-agda-hostmode
  :mode 'markdown-mode
  :keep-in-mode 'host)

(define-innermode poly-markdown-agda-innermode
  :mode 'agda2-mode
  :head-matcher "```"
  :tail-matcher "```"
  ;; Keep the code block wrappers in Org mode, so they can be folded, etc.
  :head-mode 'markdown-mode
  :tail-mode 'markdown-mode
  ;; Disable font-lock-mode, which interferes with Agda annotations,
  ;; and undo the change to indent-line-function Polymode makes.
  :init-functions '((lambda (_) (font-lock-mode 0))
                    (lambda (_) (setq indent-line-function #'indent-relative))))

(define-polymode markdown-agda-mode
  :hostmode 'poly-markdown-agda-hostmode
  :innermodes '(poly-markdown-agda-innermode)
  (when use-agda-input (set-input-method "Agda")))

(assq-delete-all 'background agda2-highlight-faces)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.lagda.md" . markdown-agda-mode))

(provide 'markdown-agda-mode)
;;; markdown-agda-mode ends here
