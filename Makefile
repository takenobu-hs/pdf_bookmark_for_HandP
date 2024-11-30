#
#
# Generate a bookmarked PDF with the toc
#
# Usage: make newpdf
#

INPDF        := book_org.pdf
OUTPDF       := book_new.pdf

TOC          := data/body_toc.tsv
BOOKMARK     := data/body_bookmark.txt
ORG_METADATA := data/metadata.org.txt
NEW_METADATA := metadata.txt

PDFTK := pdftk

.PHONY: all newpdf newmetadata bookmark orgmetadata


all: newpdf


# Extract currnet metadata from the PDF
${ORG_METADATA}: ${INPDF}
	${PDFTK} ${INPDF} dump_data > ${ORG_METADATA}

# Generate a bookmark file from the toc
${BOOKMARK}: ${TOC}
	runhaskell hs/genBookmark.hs < ${TOC} > ${BOOKMARK}

# Generate a metadata with the original metadata and the bookmark file
${NEW_METADATA}: ${BOOKMARK} ${ORG_METADATA}
	sed -e  '/BookmarkPageNumber: 22/ r ${BOOKMARK}' \
	        ${ORG_METADATA} > ${NEW_METADATA}

# Generate a new PDF with the metadata
newpdf: ${NEW_METADATA}
	${PDFTK} ${INPDF} update_info_utf8 ${NEW_METADATA} output ${OUTPDF}

