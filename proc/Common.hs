module Common where
import Data.Int
import Array
import System.Environment
readImg = struct.map (read::String->Int).words where
	struct (w:h:pxls) = ((w,h),pxls)
writeImg ((w,h),pxls) = (show w)++" "++(show h)++" "++(concat (map (\num->'\t':(show num)) pxls))
s2a ((w,h),pxls) = listArray ((1,1),(h,w)) pxls
a2s a = ((w,h),elems a) where (h,w) = snd $ bounds a
intensityTransform f (sz,pxls) = (sz,map f pxls)
applyNeighborhoodFilterA f radius imArr = listArray newsz ( map (f.ix2nb) ( ixls ((1+r,1+r),(h-r,w-r)) ) )
	where 
	r = radius
	d = r*2
	newsz = ((1,1),(h-d,w-d))
	(h,w) = snd $ bounds imArr
	ix2nb (r0,c0) = listArray nb_sz $ map (\(r,c)->imArr!(r0+r,c0+c)) (ixls nb_sz)
	nb_sz = ((-r,-r),(r,r))
ixls ((lx,ly),(rx,ry)) = [(x,y)|x<-[lx..rx],y<-[ly..ry]]
toReal i = fromIntegral i::Double
listDot x y = sum ( map (\(x,y)->x*y) (zip x y) )
roundAverage xs = round ( (toReal $ sum xs) / (toReal $ length xs) )::Int

parameterizedTool f = do
	args<-getArgs
	tool (f args)
tool f = interact (writeImg.f.readImg)

