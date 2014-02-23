import Common
import Array
import Data.List
import Data.Int
main = tool $ \(sz,pxls)->(sz,autoThreshold pxls)

autoThreshold pxls = map (thresholdImg (optimizeThreshold pxls)) pxls

thresholdImg thr v = if v<=thr then 0 else 255

optimizeThreshold xs = optimizeThrFrom guess xs where
	guess = sum xs `div` length xs

optimizeThrFrom thr xs = 
	if newThr == thr 
	then newThr
	else optimizeThrFrom newThr xs
	where
		newThr = ((s fst)+(s snd)) `div` 2
		s f = (\l->sum l `div` length l) $ f $ partition (<=thr) xs
