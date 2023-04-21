---
layout: post
title: "YubiKey and GitHub Signature Verification"
excerpt: "Improve software security by signing Git commits with a YubiKey-generated GPG key and configuring GitHub to verify commit signatures."
---

## Practice software security to fight cyberattacks

Software [supply chain attacks](https://en.wikipedia.org/wiki/Supply_chain_attack) are on the rise in recent years, as exemplified by high-profile incidents such as the $61 million Target security breach of 2013.

During a 2022 Washington, DC security summit, The Open Source Software Security Foundation (OpenSSF) brought together industry and government leaders and put forth a 10-point [Open Source Software Security Mobilization Plan](https://openssf.org/oss-security-mobilization-plan/) to improve software security. Acknowledging the growing threat of software supply chain attacks, the plan suggests [digital signature](https://en.wikipedia.org/wiki/Digital_signature) as a solution:

> Digital signatures enable a human or automated system to assert the integrity of actions taken in the software lifecycle, creating a strong guarantee that the bits the end user received are the bits the author intended. By requiring creation and verification of digital signatures for events throughout the Software Development Lifecycle (SDLC), we can bind open source software artifacts to the source code they come from, the processes that build them, and the ingredients they’re composed of, creating unparalleled transparency and security in modern systems.

Also,

> Digital signatures for software distribution must be addressed end-to-end — from original developer and development teams all the way to the end user and end device — to address a range of attack vectors increasingly being deployed.

By "original developer and development teams," OpenSSF is talking about developers like you and me. We are the ones creating and editing software source codes. We are the ones recording these changes in source code repositories. Therefore, we are the ones responsible for improving software security by adopting best practices around digital signature.

If you are using [Git](https://en.wikipedia.org/wiki/Git) and [GitHub](https://en.wikipedia.org/wiki/GitHub), one such best practice is to [sign your commits](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work) with digital signatures.

## Use digital signatures to guarantee data authenticity and integrity

Digital signatures guarantee the authenticity and integrity of electronic data. That is to say, digital signatures guarantee that a piece of electronic data comes from a known creator, and is not altered by anyone else. Digital signatures are a mature technology, having been around as early as the [publication](https://ocw.bib.upct.es/pluginfile.php/5337/mod_resource/content/1/rsa_base.pdf) of the [RSA cryptosystem](<https://en.wikipedia.org/wiki/RSA_(cryptosystem)>) concept in 1976. Like other digital signature schemes, the RSA cryptosystem meets authenticity and integrity guarantees by using [public-key cryptography](https://en.wikipedia.org/wiki/Public-key_cryptography).

Public-key cryptosystems use pairs of related keys. A key pair consists of a piece of electronic data known as the private key, and a corresponding piece of electronic data known as the public key. The owner of a key pair keeps the pair's private key secret while making the pair's public key known to others.

To sign a piece of data, the cryptosystem's signing algorithm takes the data and the private key as inputs, and generates a small piece of data as output. This output is the owner's digital signature associated with the input data.

When someone comes across the data and its associated digital signature, and want to verify the data's authenticity and integrity, they use the same cryptosystem's signature verifying algorithm. The inputs to the algorithm are the data, the digital signature, and the public key. The output of the algorithm is a true/false answer about whether the data is from its claimed creator and is unaltered.

There are several digital signature tools available today. To get started, I recommend using [GNU Privacy Guard](https://en.wikipedia.org/wiki/GNU_Privacy_Guard), or GPG. It is a free software, compliant with the industry standard OpenPGP specification, well [documented](https://gnupg.org/documentation/index.html), and available on most platforms. On the Mac, you can easily find it and install it [with Homebrew](https://formulae.brew.sh/formula/gnupg). For software developers, you would be happy to know that Git has first-class integration with GPG.

## Use smart cards to keep private keys safe

Based on the description of how public-key cryptosystems work, a keen observer will notice that, even with the most securely designed digital signature scheme, the security is only guaranteed if the scheme is properly implemented. In particular, if a key pair owner fails to keep the private key a secret, someone else can use the leaked/stolen private key to forge digital signatures.

When private keys are stored on your computer, the security of the private key depends on the security of the computer. And continuously keeping a computer secure is not a trivial task. A more secure alternative is to store the private key on an [OpenPGP card](https://en.wikipedia.org/wiki/OpenPGP_card), a physical device that takes responsibility to run cryptographic tasks such as the signing algorithm, making sure that private keys cannot be read from the device with any command or function.

There are dozens of vendors making OpenPGP cards. One of them is [Yubico](https://www.yubico.com/), and their OpenPGP card is the [YubiKey](https://en.wikipedia.org/wiki/YubiKey). If you want to learn more about best practices with the YubiKey, an excellent place to start is [drduh's YubiKey guide](https://github.com/drduh/YubiKey-Guide).

Once you have a YubiKey and have installed GPG on your computer, you are ready to generate your OpenPGP key pair to use for digital signatures. There are two options to generate your key pair:

1. Generate keys directly on your YubiKey, or
1. Generate keys on your computer, then import to your YubiKey.

The first option is more secure. It makes sure that your computer has no knowledge of the private key, even during key generation. This leaves no opportunity for attackers to steal the private key. However, this also means that you have no way to back up the private key. The key is irrecoverable if your YubiKey is lost or damaged.

Once you've weighed the options and made your decision, follow [Yubico's instructions](https://support.yubico.com/hc/en-us/articles/360013790259-Using-Your-YubiKey-with-OpenPGP) step-by-step to generate your key pair. Pay attention to the key size. To comply with [commit signature verification](commit-signature-verification), GitHub specifies that your [key must be at least **4096** bits](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key).

Use the following command to test that the generated key is ready for use. (Replace `3AA5C34371567BD2` with your key ID.)

```
echo "test" | gpg --clearsign --default-key 3AA5C34371567BD2
```

## Sign your software development work

Now that you have your own OpenPGP key pair, you can use it to sign every changeset you commit to every Git repository. To make this the default behavior, follow [GitHub's instructions](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key) to run configuration commands that resemble the following.

```
git config --global commit.gpgsign true
git config --global user.signingkey 3AA5C34371567BD2
```

If you are like me and don't have the [GPG Suite](https://gpgtools.org/), pay attention to the instructions about `export GPG_TTY=$(tty)` and/or `pinentry-mac` in the [same article](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key). Otherwise, attempting to do Git commits while your YubiKey is locked will lead to [frustrating `Inappropriate ioctl` errors](https://stackoverflow.com/questions/57591432/gpg-signing-failed-inappropriate-ioctl-for-device-on-macos-with-maven) that waste your precious development time.

Once Git is configured to automatically invoke the signing algorithm on our side, complete the scheme by configuring GitHub to invoke the signature verification algorithm on their side. Follow the [configuration steps specified by GitHub](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account).

For GitHub repository administrators: if you want to ensure contributors follow commit signature verification practices, enable "[Require signed commits](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches#require-signed-commits)" on the repository's protected branch(es).

## Further Reading

- [How (and why) to sign Git commits](https://withblue.ink/2020/05/17/how-and-why-to-sign-git-commits.html)
- [Troubleshooting GPG git commit signing](https://juliansimioni.com/blog/troubleshooting-gpg-git-commit-signing/)
- [Yubico: Troubleshooting Issues with GPG](https://support.yubico.com/hc/en-us/articles/360013714479-Troubleshooting-Issues-with-GPG)
- [Smartcard - GnuPG Wiki](https://wiki.gnupg.org/SmartCard)
- [Open Source Software Security Mobilization Plan](https://8112310.fs1.hubspotusercontent-na1.net/hubfs/8112310/OpenSSF/OSS%20Mobilization%20Plan.pdf)
- [Supply Chain Attacks: Examples and Countermeasures](https://www.fortinet.com/resources/cyberglossary/supply-chain-attacks)
- [Software Supply Chain Attacks Tripled in 2021](https://www.securityweek.com/software-supply-chain-attacks-tripled-2021-study/)
- [Cyberattack](https://en.wikipedia.org/wiki/Cyberattack)
