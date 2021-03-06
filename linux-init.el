;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;               全般設定                    ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 環境を日本語、UTF-8にする
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;;Packageインストーラ                                                               
(require 'package)                                                                  
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; CaskをLinuxで利用できるようにする
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;;;初期メッセージを表示させない
(setq inhibit-startup-message t)

;; バックアップファイルを作成させない
(setq make-backup-files nil)

;; 終了時にオートセーブファイルを削除する
(setq delete-auto-save-files t)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)

;; 括弧の自動挿入
(electric-pair-mode 1)

;; C-hをdelとして機能させる
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; C-mを改行&インデント字下げを行う
(define-key global-map (kbd "C-m") 'newline-and-indent)

;; C-t でウインドウを切り替える
(define-key global-map (kbd "C-t") 'other-window)

;; C-zを無効化(emacs強制終了)
(global-unset-key "\C-z")

;; タブ幅
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-display-errors-delay 0.5)
 '(flycheck-display-errors-function
   (lambda
     (errors)
     (let
         ((messages
           (mapcar
            (function flycheck-error-message)
            errors)))
       (popup-tip
        (mapconcat
         (quote identity)
         messages "
")))))
 '(package-selected-packages
   (quote
    (color-theme-modern yasnippet rainbow-delimiters racer irony helm flycheck-rust elscreen company-racer color-theme auto-complete-c-headers)))
 '(tab-width 4))

;; scratchの初期メッセージ消去                                        
(setq initial-scratch-message "")    

;; 改行コードを表示する
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; 列数を表示する
(column-number-mode t)

;; 行番号を常に表示させる                                                          
(global-linum-mode)
(setq linum-format "%4d ")                                                           

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;; 時間も表示させる。                                                               
(display-time) 

 ;; マウスコピーを可能にする                                                        
(setq mouse-drag-copy-region t)  

;; スクロールは１行ごとに
(setq scroll-conservatively 1)

;; C-kで行全体を削除する
(setq kill-whole-line t)

;;;行頭まで削除する
(defun backward-kill-line (arg)
  "Kill chars backward until encountering the end of a line."
  (interactive "p")
  (kill-line 0))
(global-set-key (kbd "C-u") 'backward-kill-line)

;; "yes or no" の選択を "y or n" にする
(fset 'yes-or-no-p 'y-or-n-p)

;; Macのoptionをメタキーにする
(setq mac-option-modifier 'meta)

;; M-hで単語削除をできるようにする.
(global-set-key (kbd "M-h" ) (kbd "M-<DEL>"))

;; color theme
(require 'color-theme-modern)
(load-theme 'railscast t t)
(enable-theme 'railscast)
;(color-theme-initialize)
;(load-file "~/.emacs.d/site-lisp/themes/color-theme-railscasts.el")
;(color-theme-railscasts)

;; alpha
;;(if window-system
;;    (progn
;;      (set-frame-parameter nil 'alpha 95)))

;; メニューバーを非表示
(menu-bar-mode 0)

;; リージョンのハイライト
(transient-mark-mode 1)

;; タイトルにフルパス表示
(setq frame-title-format "%f")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;       Pakageによるインストール            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Auto Complete
(require 'auto-complete)
(require 'auto-complete-config)
;; Lisp以外の言語でもオートコンプリート機能をONにする.
(ac-config-default)
;; TABキーで自動補完を有効にする
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "\C-t")
;; auto-complete-mode を起動時に有効にする
(global-auto-complete-mode t)
;; auto-completeの補完候補で上下移動を可能にする
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; yamlを編集するためのモード
;(require 'yaml-mode)
;(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
;(define-key yaml-mode-map "\C-m" 'newline-and-indent)


;; Elscreenはタブエディタとなる.
;; C-zから始める.
(require 'elscreen)
(elscreen-start)
(set-face-attribute 'elscreen-tab-background-face nil
                    :background "grey10"
                    :foreground "grey90")
(set-face-attribute 'elscreen-tab-control-face nil
                    :background "grey20"
                    :foreground "grey90")
(set-face-attribute 'elscreen-tab-current-screen-face nil
                    :background "grey20"
                    :foreground "grey90")
(set-face-attribute 'elscreen-tab-other-screen-face nil
                    :background "grey30"
                    :foreground "grey60")

;;; [X]を表示しない
(setq elscreen-tab-display-kill-screen nil)
;;; [<->]を表示しない
(setq elscreen-tab-display-control nil)
;;; タブに表示させる内容を決定
(setq elscreen-buffer-to-nickname-alist
      '(("^dired-mode$" .
         (lambda ()
           (format "Dired(%s)" dired-directory)))
        ("^Info-mode$" .
         (lambda ()
           (format "Info(%s)" (file-name-nondirectory Info-current-file))))
        ("^mew-draft-mode$" .
         (lambda ()
           (format "Mew(%s)" (buffer-name (current-buffer)))))
        ("^mew-" . "Mew")
        ("^irchat-" . "IRChat")
        ("^liece-" . "Liece")
        ("^lookup-" . "Lookup")))
(setq elscreen-mode-to-nickname-alist
      '(("[Ss]hell" . "shell")
        ("compilation" . "compile")
        ("-telnet" . "telnet")
        ("dict" . "OnlineDict")
        ("*WL:Message*" . "Wanderlust")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;         Caskによるインストール            ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; auto complete -> company
(require 'company)

;; rainbow-delimiters を使うための設定
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)        

;;helm
(require 'helm-config)
(helm-mode 1)

;; helmにてC-hで前の文字削除
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)                 
(define-key global-map (kbd "C-x C-b")   'helm-buffers-list)
(define-key global-map (kbd "C-x C-f") 'helm-for-files)

;; 括弧の色を強調する設定
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
      (interactive)
      (cl-loop
              for index from 1 to rainbow-delimiters-max-face-count
              do
              (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))                 (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)


;; c-mode-common-hook は C/C++/Java の設定
(require 'cc-mode)
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq c-default-style "k&r") ;; カーニハン・リッチースタイル
            (setq indent-tabs-mode nil)  ;; タブは利用しない
            (setq c-basic-offset 2)      ;; indent は 2 スペース
            ))

;; gtags(for C / C++)
(add-to-list 'load-path "/usr/local/share/gtags")
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)    ;関数へジャンプ
         (local-set-key "\M-r" 'gtags-find-rtag)   ;関数の参照元へジャンプ
         (local-set-key "\M-s" 'gtags-find-symbol) ;変数の定義元/参照先へジャンプ
         (local-set-key "\C-t" 'gtags-pop-stack)   ;前のバッファに戻る
         ))
(add-hook 'c-mode-hook 'gtags-mode)
(add-hook 'c++-mode-hook 'gtags-mode)


;; ヘッダファイルをC++として認識させる.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; エラーチェック(flycheck)
(add-hook 'c-mode-common-hook 'flycheck-mode)

;; yasnippetは定型文をsnippetディレクトリに保存すれば使える.
(eval-after-load "yasnippet"
  '(progn
     (define-key yas-keymap (kbd "<tab>") nil)
     (yas-global-mode 1)))

;; ironyは
(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
;; (add-hook 'rust-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;;(add-to-list 'company-backends 'company-backends)

;;
;;(when (require 'package nil 'noerror)
;;  (add-to-list 'package-archives
;;               '("melpa" . "http://melpa.milkbox.net/packages/"))
;;  (package-initialize))

;; yasnippet
;;
(eval-after-load "yasnippet"
  '(progn
     ;; companyと競合するのでyasnippetのフィールド移動は "C-i" のみにする
     (define-key yas-keymap (kbd "<tab>") nil)
     (yas-global-mode 1)))

;; company-mode : auto-completeの補完
(when (locate-library "company")
  (global-company-mode 1)
  (global-set-key (kbd "C-M-i") 'company-complete)
  ;; (setq company-idle-delay nil) ; 自動補完をしない
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "<tab>") 'company-complete-selection))

;; flycheck
(when (require 'flycheck nil 'noerror)
  (custom-set-variables
   ;; エラーをポップアップで表示
   '(flycheck-display-errors-function
     (lambda (errors)
       (let ((messages (mapcar #'flycheck-error-message errors)))
         (popup-tip (mapconcat 'identity messages "\n")))))
   '(flycheck-display-errors-delay 0.5))
  (define-key flycheck-mode-map (kbd "C-M-n") 'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "C-M-p") 'flycheck-previous-error)
  (add-hook 'c-mode-common-hook 'flycheck-mode))

;; flycheck-irony(C, C++, Obj-C環境にてflycheckを強化する.)
(eval-after-load "flycheck"
  '(progn
     (when (locate-library "flycheck-irony")
       (flycheck-irony-setup))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
