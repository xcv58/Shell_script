#!/usr/bin/env sh -x

# Clear the twitter internal npm/yarn setup
sed -i '' -e '/^registry.*twitter.biz.*$/d' ~/.yarnrc
sed -i '' -e '/^prefix=\/Users\/.*\.npm\-global$/d' ~/.npmrc
sed -i '' -e '/^registry.*twitter.biz.*$/d' ~/.npmrc
