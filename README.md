# AnimationTest
Texture animations are weird.

## Problem
Texture animations omit the last frame in the sequence. There doesn't appear to be any difference when aligning texture frames in a single row (e.g. 4x1) or in a square (e.g. 2x2). The last frame is dropped in both arrangements.

## Workaround
Add another empty frame to the end? A 4x1 animation displays all frames when built as a 5x1 animation with the last frame empty.
