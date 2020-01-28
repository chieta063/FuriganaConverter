# FuriganaConverter

## 開発環境

### IDE
Xcode 11.3

### Target
iOS 13.2

## 使用ライブラリ
### CocoaPod
- R.swift
- UITextView+Placeholder

### Carthage
- RxSwift
- RxOptional
- RxAlamofire
- SnapKit
- ReactorKit
- Swinject
- SwinjectAutoregistration

### Installation
アプリを起動するために以下のコマンドを順に実行してください。
``` zsh
## bundle
bundle install

## CocoaPod
pod install

## Carthage
carthage update --platform iOS

## ReactorKit
cd Carthage/Checkouts/ReactorKit && swift package generate-xcodeproj
carthage build --platform iOS --cache-builds　## プロジェクトのルートディレクトリに移動して実行
```
