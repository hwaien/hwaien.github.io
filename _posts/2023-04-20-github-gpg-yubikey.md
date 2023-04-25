---
layout: post
title: "YubiKey and GitHub Signature Verification"
excerpt: "Improve software security by signing Git commits with a YubiKey-managed GPG key and configuring GitHub to verify commit signatures."
---

## Practice software security to fight cyberattacks

Software [supply chain attacks](https://en.wikipedia.org/wiki/Supply_chain_attack) are on the rise in recent years, as exemplified by high-profile incidents such as the [Target security breach of 2013](https://www.zdnet.com/article/the-target-breach-two-years-later/).

During a 2022 Washington, DC security summit, the Open Source Software Security Foundation (OpenSSF) brought together industry and government leaders and put forth the 10-point [Open Source Software Security Mobilization Plan](https://openssf.org/oss-security-mobilization-plan/) to improve software security. Acknowledging the growing threat of software supply chain attacks, the plan suggests [digital signature](https://en.wikipedia.org/wiki/Digital_signature) as a solution:

> Digital signatures enable a human or automated system to assert the integrity of actions taken in the software lifecycle, creating a strong guarantee that the bits the end user received are the bits the author intended. By requiring creation and verification of digital signatures for events throughout the Software Development Lifecycle (SDLC), we can bind open source software artifacts to the source code they come from, the processes that build them, and the ingredients they’re composed of, creating unparalleled transparency and security in modern systems.

Also,

> Digital signatures for software distribution must be addressed end-to-end — from original developer and development teams all the way to the end user and end device — to address a range of attack vectors increasingly being deployed.

By "original developer and development teams," OpenSSF is talking about developers like you and me. We are the ones creating and editing software source codes. We are the ones pushing these changes to source code repositories. We are the ones responsible for adopting software security best practices.

If you are using [Git](https://en.wikipedia.org/wiki/Git) and [GitHub](https://en.wikipedia.org/wiki/GitHub), one such best practice is to [sign your commits](https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work) with digital signatures.

## Use digital signatures to guarantee data authenticity and integrity

Digital signatures guarantee the authenticity and integrity of electronic data. That is to say, digital signatures guarantee that a piece of electronic data comes from a known source, and is not altered by anyone else. Digital signature schemes are a mature technology, having been around as early as the [publication](https://ocw.bib.upct.es/pluginfile.php/5337/mod_resource/content/1/rsa_base.pdf) of the [RSA cryptosystem](<https://en.wikipedia.org/wiki/RSA_(cryptosystem)>) concept in the 1970s. Like other digital signature schemes, the RSA cryptosystem meets authenticity and integrity guarantees by using [public-key cryptography](https://en.wikipedia.org/wiki/Public-key_cryptography).

Public-key cryptosystems are built around the concept of key pairs. A key pair consists of a piece of information known as the private key, and a corresponding piece of information known as the public key. The owner of a key pair keeps the pair's private key secret while making the pair's public key known to others.

To sign a piece of data, the cryptosystem's signing algorithm takes the data and the private key as inputs, and generates a unique output known as the owner's digital signature associated with the input data.

When someone comes across the data and its associated digital signature, and want to verify the data's authenticity and integrity, they are to use the same cryptosystem's signature verifying algorithm. The inputs to the algorithm are the data, the digital signature, and the public key. The output of the algorithm is a true/false answer about whether the data is from its claimed source and is unaltered.

There are several digital signature tools available today. To get started, I recommend that you use [GNU Privacy Guard](https://en.wikipedia.org/wiki/GNU_Privacy_Guard) (GPG). It is a free software, compliant with the industry standard [OpenPGP](https://www.openpgp.org/about/) specification, well [documented](https://gnupg.org/documentation/index.html), and available on most platforms. On the Mac, you can easily [install GPG with Homebrew](https://formulae.brew.sh/formula/gnupg). For software developers, you will be happy to know that Git has first-class integration with GPG.

## Use smart cards to keep private keys safe

Based on the description of how public-key cryptosystems work, a keen observer will notice that, even with the most securely designed digital signature scheme, the security is only guaranteed if the scheme is properly implemented. In particular, if a key pair owner fails to keep the private key a secret, someone else can use the leaked/stolen private key to forge digital signatures.

When private keys are stored on your computer, the security of the private key depends on the security of the computer. To keep a computer secure is not a trivial task. An alternative is to store the private key on an [OpenPGP card](https://en.wikipedia.org/wiki/OpenPGP_card), a physical device that takes responsibility to run cryptographic tasks such as the signing algorithm, making sure that private keys can never be read from the device.

There are dozens of vendors making OpenPGP cards. One of them is [Yubico](https://www.yubico.com/), and their OpenPGP card is the [YubiKey](https://en.wikipedia.org/wiki/YubiKey). If you want to familiarize yourself with the YubiKey, an excellent place to start is [drduh's YubiKey guide](https://github.com/drduh/YubiKey-Guide).

Once you have a YubiKey and have installed GPG on your computer, you are ready to generate your own OpenPGP key pair to use for digital signatures. There are two options to generate your key pair:

1. Generate keys directly on your YubiKey, or
1. Generate keys on your computer, then import to your YubiKey.

The first option is more secure. It makes sure that your computer has no knowledge of the private key, even during key generation. This leaves no opportunity for attackers to steal the private key. However, this also means that you have no way to back up the private key. The key is irrecoverable if your YubiKey is lost or damaged. If recovery is important to you, choose the second option.

Once you've weighed the options and made your decision, follow [Yubico's instructions](https://support.yubico.com/hc/en-us/articles/360013790259-Using-Your-YubiKey-with-OpenPGP) step-by-step to generate your key pair. Pay attention to the key size. To comply with GitHub's [commit signature verification](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification), your key must be [at least **4096** bits](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key).

Once you finish generating your key pair, use the following command to confirm that you can use it to generate digital signatures. (Replace `3AA5C34371567BD2` with your key ID.)

```
echo "test" | gpg --clearsign --default-key 3AA5C34371567BD2
```

## Sign your software development work

With your own OpenPGP key pair, you can now use it to sign every changeset you commit to every Git repository. To make this the default behavior, follow [GitHub's instructions](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key) to run configuration commands that resemble the following.

```
git config --global commit.gpgsign true
git config --global user.signingkey 3AA5C34371567BD2
```

Side note: I do not have [GPG Suite](https://gpgtools.org/) installed. If you are like me, pay attention to the instructions about `export GPG_TTY=$(tty)` and/or `pinentry-mac` in the [same article](https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key). Otherwise, attempting to do Git commits while your YubiKey is locked will lead to [frustrating `Inappropriate ioctl` errors](https://stackoverflow.com/questions/57591432/gpg-signing-failed-inappropriate-ioctl-for-device-on-macos-with-maven) that waste your precious development time.

Once Git is configured to automatically invoke the signing algorithm on your end, close the loop by configuring GitHub to invoke the signature verification algorithm on their end. Follow the [configuration steps specified by GitHub](https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account).

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
