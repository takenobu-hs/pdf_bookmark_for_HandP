# PDF bookmarks for HandP (Computer Architecture, 6th) Japanese version

This is unofficial information on how to add bookmarks (outline) to the Japanese version PDF of "Computer Architecture: A Quantitative Approach, Sixth Edition".


## Overivew

The book is available for purchase from the following link:
  * https://tatsu-zine.com/books/computer-architecture-6ed

This PDF does not have bookmarks (outline) in the content. Therefore, you can add them using the data from this repository and following the steps below.


## Disclaimer

> [!CAUTION]
> This procedure is provided without any guarantees.
> Please make sure to back up the original PDF to avoid any potential damage to it.

## Step

For example, by following the steps below, you can generate a new PDF with added bookmarks.

```bash
$ pdftk ORIGINAL.pdf dump_data > data/metadata.org.txt

$ sed -e  '/BookmarkPageNumber: 22/ r data/body_bookmark.txt' data/metadata.org.txt > metadata.txt

$ pdftk ORIGINAL.pdf update_info_utf8 metadata.txt output NEW.pdf
```
