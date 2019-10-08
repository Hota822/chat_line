(package-initialize)

;; path setting
(package-initialize)
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;パッケージ管理の------------------------------------------------------------
;; el-get enable or install from GitHub
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; package install (el-get-list-packages el-get-remove)
;;(el-get-bundle init-loader);;設定ファイルを分割するやつ
;;(el-get-bundle ivy-yasnippet)
(el-get-bundle yasnippet)
(el-get-bundle yasnippet-config)
(el-get-bundle yasnippet-snippets)
(el-get-bundle yasnippets)
(el-get-bundle web-mode)
(el-get-bundle golden-ratio)
;;(el-get-bundle helm)
;;(el-get-bundle helm-gtags)
;;(el-get-bundle helm-descbinds)
(el-get-bundle ivy
  :url "https://github.com/abo-abo/swiper.git"
  :features ivy)
(el-get-bundle company-mode)
(el-get-bundle company-web)

;; (setq package-archives
;;       '(("gnu" . "http://elpa.gnu.org/packages/")
;; 	("melpa" . "http://melpa.org/packages/")
;; 	        ("org" . "http://orgmode.org/elpa/")))


;;テーマ設定-----------------------------------------------------
;;(load-theme 'deeper-blue t) ;;画面青いからやだ
;;(load-theme 'desert t)
;;(load-theme 'misterioso t)
(load-theme 'wombat t)

;;バックアップファイの作成----------------------------------------
;;#がつくオートセーブファイル
(setq auto-save-default nil)
;;~がつくバックアップファイル
(setq make-backup-files nil)


;;キーバインド関連-------------------------------------------------
;;Chにバックスペースの割り当て
;;keyboard-translateはできるだけ使わないほうが良い
(global-set-key "\C-h" 'delete-backward-char)
;; helpの表示
(global-set-key "\C-c\C-h" 'help-command)
;; comment out?
(global-set-key "\C-c;" 'comment-dwim)
;; 別のウインドウに移動
(global-set-key "\C-t" 'other-window)
;;MacでOptキーをMetaキーに変更

;;行番号の設定------------------------------------------------------
;;(global-linum-mode t);;左詰めで番号が出力、境目がわかりづらいため、不採用
;;行番号のところの色は今のところいじっていない
 (progn
   (global-display-line-numbers-mode)
   (set-face-attribute 'line-number nil)
;; 		      :foreground "DarkOliveGreen"
;; 		      :background "#131521")
   (set-face-attribute 'line-number-current-line nil ))
;; 		                                :foreground "gold"))



;;表示系--------------------------------------------------------
;;対応する括弧を常に表示
(show-paren-mode 1)
;;現在の行を強調表示
;;(setq h1-line-face 'unerline
;;(global-h1-line-mode t)
;;描画崩れを防止（メニューの非表示）
(menu-bar-mode -1)

;;パッケージの設定--------------------------------------------------
;;スニペット機能、自動入力(yasnippet)
(yas-global-mode 1)

;;スニペット機能、自動入力(company)
(require 'company)
(global-company-mode)

;;web-mode(フロント特化の補完、自動入力等）
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;;company-web(フロント特化の補完、自動入力等）
;; (require 'company-web)
;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . company-web))
;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . company-web))
;; (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . company-web))
;; (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . company-web))
;; (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . company-web))
;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . company-web))
;; (add-to-list 'auto-mode-alist '("\\.mustache\\'" . company-web))
;; (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . company-web))

;;ivy (ファイルの選択用）
(require 'ivy)
(ivy-mode 1)

;;golden-ratio（画面幅の自動調整）
(golden-ratio-mode 1)



;;その他------------------------------------------------------------
;;ビープ音を削除
;;(setq ring-bell-funciton 'ignore)

;;Rubyでマジックコメント（文字コード）の自動挿入の停止
(setq ruby-insert-encoding-magic-comment nil)

;;導入検討---------------------------------------------------------
;; スクロールは1行ごとに
(setq mouse-wheel-scroll-amount '(1 ((shift) . 5)))
;; スクロールの加速をやめる
(setq mouse-wheel-progressive-speed nil)
