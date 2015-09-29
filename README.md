# Auto-expand estonian words with accented characters on OSX when using an english keyboard layout

I use en-US keyboard layout for programming but it's difficult to switch between english and estonian
layouts all the time (using estonian for chatting).

This is a helper to leverage the osx's built-in auto-expand feature to import a bunch of estonian words and
be able to type them with an english keyboard layout. The location of the accented characters is the same as they
would be if we were using the estonian layout'

e.g. `h'sti` -> `hästi`, `k]ik` -> `kõik`, `n[[d` -> `nüüd`, `;;' -> 'öö'
Also supports sh and zh.

## Sad trombone

It turns out though that there are about 100,000 words containing accented characters in Estonian (including cases and whatnot).
Including all of those **crashes the osx's keyboard settings view** and apps like TextEdit.

So we're using the 1000 most common words.

Full list of estonian words with frequencies from:

  https://invokeit.wordpress.com/frequency-word-lists/

## Usage

- Run `./extract_accented_words.sh`.
  This generates `words.txt` which contains all the words that will be included.

- Run `./import_csv.sh ~/Library/Dictionaries/CoreDataUbiquitySupport/<some hash here>/UserDictionary/local/store/UserDictionary.db`.
  This imports all the words, generates a temporary csv file and imports it into osx's auto-expand db file, ignoring all metadata (like created-at date). Also runs `killall AppleSpell` to force-reload the spelling service.

- Profit. The auto-expand list now contains all the words: ![Keyboard Settings View](example.png)

You need to pass in the location of the dictionary db file to the last command. In Yosemite it's found in `~/Library/Dictionaries/CoreDataUbiquitySupport/<some hash here>/UserDictionary/local/store/UserDictionary.db`. This is an sqlite3 database file. A backup is made in bak/ and it won't be overwritten but subsequent calls to `import_csv.sh`.

Note: Only supports lowercase words because osx's auto-expand is case insensitive and the snippets are used in
unknown order so there's no way to force it to use the uppercase version if you type an uppercase letter first. (`H'sti` vs `h'sti`)