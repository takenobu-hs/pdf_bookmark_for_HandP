
--
-- | Generate bookmarks for the PDF.
--
-- Of course, you can use awk instead of haskell :)
--
-- Usage: $ doctest genBookmark.hs < TOC.tsv
--
--

import Data.List (isPrefixOf)
import Data.List.Split (splitOn)
import Text.Printf (printf)


main :: IO ()
main = do
    xs <- lines <$> getContents
    let xs2 = filter (not . null) . filter (not . isPrefixOf "#") $ xs
    let xs3 = map (genOutline . genElems) xs2
    mapM_ putStr xs3


-- | Generate elements
--
-- >>> genElems td1
-- ("1","62","chapter 2 memory")
genElems :: String -> (String, String, String)
genElems s = (level, show (page + pageoffset), item)
  where
    [level, p, item] = take 3 $  splitOn "\t" s
    page = read p :: Int

-- Page offset for begin of body
pageoffset :: Int
pageoffset = 21


-- | Generate bookmarks
--
-- >>> genBookmark ("3", "10", "Chapter 3 threads")
-- "BookmarkBegin\nBookmarkTitle: Chapter 3 threads\nBookmarkLevel: 3\nBookmarkPageNumber: 10\n"
genOutline :: (String, String, String) -> String
genOutline (level, page, item) = printf format item level page

format :: String
format = "BookmarkBegin\nBookmarkTitle: %s\nBookmarkLevel: %s\nBookmarkPageNumber: %s\n"


-- test data    
td1 = "1\t41\tchapter 2 memory"

