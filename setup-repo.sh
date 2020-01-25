#!/bin/bash
git config commit.gpgsign true
git config gpg.program "$(command -v gpg21 gpg2 gpg | head -1)"
git config user.signingkey 97A0AE5E03F3499B7D7A65C676A4143237EF5817
git config user.signingkey 97A0AE5E03F3499B7D7A65C676A4143237EF5817
git config user.email "luizribeiro@gmail.com"
