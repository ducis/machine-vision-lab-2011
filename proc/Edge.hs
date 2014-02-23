import Common
import Data.List
import Data.Array
main = parameterizedTool $ \[kernel_type]->a2s.
	applyNeighborhoodFilterA (firstOrderDiff $ get_kernel kernel_type ) 1
	.s2a

get_kernel = k where
	k "r" = ([0,0,0,
		  0,1,0,
		  0,0,-1],
		 [0,0,0,
		  0,0,-1,
		  0,1,0]) --Robert
	k "s" = sym 
		[[-1,0,1],
		 [-2,0,2],
		 [-1,0,1]] --Sobel
	k "p" = sym
		[[-1,0,1],
		 [-1,0,1],
		 [-1,0,1]] --Prewitt
	sym m = ( concat (transpose m), concat m )
firstOrderDiff (kx,ky) nb = round (sqrt (f kx + f ky))::Int
--firstOrderDiff (kx,ky) nb = sqrt (f kx + f ky)
	where
	f k = (toReal $ (listDot k $ elems nb)^2) / (toReal $ sum (map (^2) k))

