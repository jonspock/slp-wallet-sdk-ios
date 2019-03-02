# SLPWallet iOS SDK

## Installation

### CocoaPods

#### Podfile

```ruby
platform :ios, '10.0'

target 'SLPWalletTestApp' do
use_frameworks!

# Pods for SLPWalletTestApp
pod 'SLPWallet', :git => 'https://github.com/bitcoin-portal/slp-wallet-sdk-ios.git', :branch => 'master'

end
```
#### Commands

```bash
$ brew install autoconf automake // Required with BitcoinKit
$ brew install libtool // Required with BitcoinKit
$ pod install
```

#### Pod install issue

```bash 
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer/
```

## Get Started

### Creating new wallet with/without mnemonic

The wallet is working with only 1 address using the SLP recommanded path 44'/245'/0' + m/0/0.

```swift
let wallet = SLPWallet("my mnemonic", network: .testnet) // .mainnet or .testnet
// Or generate mnemonic + create wallet
let wallet = SLPWallet(.testnet) // .mainnet or .testnet
```

### Addresses + tokens

```swift
wallet.mnemonic
wallet.slpAddress
wallet.cashAddress
wallet.tokens // Tokens accessible if you fetch it already once or you started the scheduler
```
### Fetch my tokens

```swift
wallet
    .fetchTokens() // RxSwift => Single<[String:Token]>
    .subscribe(onSuccess: { tokens in
        // My tokens
        tokens.forEach({ tokenId, token in
            token.tokenId
            token.tokenName
            token.tokenTicker
            token.decimal
            token.getBalance()
            token.getGas()
        })
    }, onError: { error in
        // ...
    })
```
### Auto update wallet/tokens (balances + gas)

```swift
// Start & stop
wallet.scheduler.resume()
wallet.scheduler.suspend()

// Change the interval
wallet.schedulerInterval = 10 // in seconds
```
### WalletDelegate called when the scheduler is started

```swift
class MyViewController: SLPWalletDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let wallet = ... // Setup a wallet
        wallet.delegate = self
    }

    func onUpdatedToken(_ tokens: [String:SLPToken]) {
        // My updated tokens
        tokens.forEach({ tokenId, token in
            token.tokenId
            token.tokenName
            token.tokenTicker
            token.decimal
            token.getBalance()
            token.getGas()
        })
    }
}
```

## Authors & Maintainers
- [jbdtky](https://github.com/jbdtky)
- [holemcross](https://github.com/holemcross)

## License

SLPWallet iOS SDK is available under the MIT license. See the LICENSE file for more info.
