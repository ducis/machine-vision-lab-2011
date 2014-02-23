import Common
import Data.Array
import Data.List
main = parameterizedTool makeFunc
makeFunc [rad_str,filter_type] = a2s.applyNeighborhoodFilterA ( s filter_type ) r.s2a
	where 
	r = (read rad_str)::Int
	s "a" = averagingFilter
	s "g" = \img->round ( listDot (map toReal $ elems img) (gaussian2Ds !! r) ) --gaussian filter
	s "m" = \img->sort (elems img) !! (2*r*(r+1)) --median filter
	s "e" = edgePreservingFilter r
averagingFilter nb = roundAverage $ elems nb
edgePreservingFilter r nb = avg ( minimum $ map (f.pxls_of_quadrant) [(x,y)|x<-p,y<-p] )
--edgePreservingFilter r nb = (f.pxls_of_quadrant)
	where 
	p = [-r,0]
	pxls_of_quadrant (lx,ly) = map (nb!) $ ixls ((lx,ly),(lx+r,ly+r))
	f pxls = (variance pxls,pxls)
	variance g = sum (map (^2) g) - (((sum g)^2) `div` length g)
	avg (_,g) = roundAverage g
gaussian2Ds = [
   [1],
   [0.0113,    0.0838,    0.0113,
    0.0838,    0.6193,    0.0838,
    0.0113,    0.0838,    0.0113],
   [0.0030,    0.0133,    0.0219,    0.0133,    0.0030,
    0.0133,    0.0596,    0.0983,    0.0596,    0.0133,
    0.0219,    0.0983,    0.1621,    0.0983,    0.0219,
    0.0133,    0.0596,    0.0983,    0.0596,    0.0133,
    0.0030,    0.0133,    0.0219,    0.0133,    0.0030],
   [0.0013,    0.0041,    0.0079,    0.0099,    0.0079,    0.0041,    0.0013,
    0.0041,    0.0124,    0.0241,    0.0301,    0.0241,    0.0124,    0.0041,
    0.0079,    0.0241,    0.0470,    0.0587,    0.0470,    0.0241,    0.0079,
    0.0099,    0.0301,    0.0587,    0.0733,    0.0587,    0.0301,    0.0099,
    0.0079,    0.0241,    0.0470,    0.0587,    0.0470,    0.0241,    0.0079,
    0.0041,    0.0124,    0.0241,    0.0301,    0.0241,    0.0124,    0.0041,
    0.0013,    0.0041,    0.0079,    0.0099,    0.0079,    0.0041,    0.0013],
   [0.0008,    0.0018,    0.0034,    0.0050,    0.0056,    0.0050,    0.0034,    0.0018,    0.0008,
    0.0018,    0.0044,    0.0082,    0.0119,    0.0135,    0.0119,    0.0082,    0.0044,    0.0018,
    0.0034,    0.0082,    0.0153,    0.0223,    0.0253,    0.0223,    0.0153,    0.0082,    0.0034,
    0.0050,    0.0119,    0.0223,    0.0325,    0.0368,    0.0325,    0.0223,    0.0119,    0.0050,
    0.0056,    0.0135,    0.0253,    0.0368,    0.0417,    0.0368,    0.0253,    0.0135,    0.0056,
    0.0050,    0.0119,    0.0223,    0.0325,    0.0368,    0.0325,    0.0223,    0.0119,    0.0050,
    0.0034,    0.0082,    0.0153,    0.0223,    0.0253,    0.0223,    0.0153,    0.0082,    0.0034,
    0.0018,    0.0044,    0.0082,    0.0119,    0.0135,    0.0119,    0.0082,    0.0044,    0.0018,
    0.0008,    0.0018,    0.0034,    0.0050,    0.0056,    0.0050,    0.0034,    0.0018,    0.0008],
   [0.0005,    0.0010,    0.0018,    0.0026,    0.0034,    0.0036,    0.0034,    0.0026,    0.0018,    0.0010,    0.0005,
    0.0010,    0.0021,    0.0036,    0.0054,    0.0069,    0.0075,    0.0069,    0.0054,    0.0036,    0.0021,    0.0010,
    0.0018,    0.0036,    0.0064,    0.0095,    0.0121,    0.0131,    0.0121,    0.0095,    0.0064,    0.0036,    0.0018,
    0.0026,    0.0054,    0.0095,    0.0142,    0.0180,    0.0195,    0.0180,    0.0142,    0.0095,    0.0054,    0.0026,
    0.0034,    0.0069,    0.0121,    0.0180,    0.0229,    0.0248,    0.0229,    0.0180,    0.0121,    0.0069,    0.0034,
    0.0036,    0.0075,    0.0131,    0.0195,    0.0248,    0.0269,    0.0248,    0.0195,    0.0131,    0.0075,    0.0036,
    0.0034,    0.0069,    0.0121,    0.0180,    0.0229,    0.0248,    0.0229,    0.0180,    0.0121,    0.0069,    0.0034,
    0.0026,    0.0054,    0.0095,    0.0142,    0.0180,    0.0195,    0.0180,    0.0142,    0.0095,    0.0054,    0.0026,
    0.0018,    0.0036,    0.0064,    0.0095,    0.0121,    0.0131,    0.0121,    0.0095,    0.0064,    0.0036,    0.0018,
    0.0010,    0.0021,    0.0036,    0.0054,    0.0069,    0.0075,    0.0069,    0.0054,    0.0036,    0.0021,    0.0010,
    0.0005,    0.0010,    0.0018,    0.0026,    0.0034,    0.0036,    0.0034,    0.0026,    0.0018,    0.0010,    0.0005],
   [0.0003,    0.0006,    0.0010,    0.0015,    0.0020,    0.0024,    0.0025,    0.0024,    0.0020,    0.0015,    0.0010,    0.0006,    0.0003,
    0.0006,    0.0012,    0.0019,    0.0028,    0.0037,    0.0044,    0.0047,    0.0044,    0.0037,    0.0028,    0.0019,    0.0012,    0.0006,
    0.0010,    0.0019,    0.0032,    0.0047,    0.0062,    0.0073,    0.0077,    0.0073,    0.0062,    0.0047,    0.0032,    0.0019,    0.0010,
    0.0015,    0.0028,    0.0047,    0.0069,    0.0091,    0.0108,    0.0114,    0.0108,    0.0091,    0.0069,    0.0047,    0.0028,    0.0015,
    0.0020,    0.0037,    0.0062,    0.0091,    0.0120,    0.0142,    0.0150,    0.0142,    0.0120,    0.0091,    0.0062,    0.0037,    0.0020,
    0.0024,    0.0044,    0.0073,    0.0108,    0.0142,    0.0168,    0.0178,    0.0168,    0.0142,    0.0108,    0.0073,    0.0044,    0.0024,
    0.0025,    0.0047,    0.0077,    0.0114,    0.0150,    0.0178,    0.0188,    0.0178,    0.0150,    0.0114,    0.0077,    0.0047,    0.0025,
    0.0024,    0.0044,    0.0073,    0.0108,    0.0142,    0.0168,    0.0178,    0.0168,    0.0142,    0.0108,    0.0073,    0.0044,    0.0024,
    0.0020,    0.0037,    0.0062,    0.0091,    0.0120,    0.0142,    0.0150,    0.0142,    0.0120,    0.0091,    0.0062,    0.0037,    0.0020,
    0.0015,    0.0028,    0.0047,    0.0069,    0.0091,    0.0108,    0.0114,    0.0108,    0.0091,    0.0069,    0.0047,    0.0028,    0.0015,
    0.0010,    0.0019,    0.0032,    0.0047,    0.0062,    0.0073,    0.0077,    0.0073,    0.0062,    0.0047,    0.0032,    0.0019,    0.0010,
    0.0006,    0.0012,    0.0019,    0.0028,    0.0037,    0.0044,    0.0047,    0.0044,    0.0037,    0.0028,    0.0019,    0.0012,    0.0006,
    0.0003,    0.0006,    0.0010,    0.0015,    0.0020,    0.0024,    0.0025,    0.0024,    0.0020,    0.0015,    0.0010,    0.0006,    0.0003],
   [0.0003,    0.0004,    0.0007,    0.0010,    0.0013,    0.0016,    0.0018,    0.0019,    0.0018,    0.0016,    0.0013,    0.0010,    0.0007,    0.0004,    0.0003,
    0.0004,    0.0007,    0.0011,    0.0017,    0.0022,    0.0027,    0.0031,    0.0032,    0.0031,    0.0027,    0.0022,    0.0017,    0.0011,    0.0007,    0.0004,
    0.0007,    0.0011,    0.0018,    0.0026,    0.0035,    0.0042,    0.0048,    0.0050,    0.0048,    0.0042,    0.0035,    0.0026,    0.0018,    0.0011,    0.0007,
    0.0010,    0.0017,    0.0026,    0.0038,    0.0050,    0.0061,    0.0069,    0.0072,    0.0069,    0.0061,    0.0050,    0.0038,    0.0026,    0.0017,    0.0010,
    0.0013,    0.0022,    0.0035,    0.0050,    0.0066,    0.0081,    0.0092,    0.0096,    0.0092,    0.0081,    0.0066,    0.0050,    0.0035,    0.0022,    0.0013,
    0.0016,    0.0027,    0.0042,    0.0061,    0.0081,    0.0100,    0.0113,    0.0118,    0.0113,    0.0100,    0.0081,    0.0061,    0.0042,    0.0027,    0.0016,
    0.0018,    0.0031,    0.0048,    0.0069,    0.0092,    0.0113,    0.0128,    0.0133,    0.0128,    0.0113,    0.0092,    0.0069,    0.0048,    0.0031,    0.0018,
    0.0019,    0.0032,    0.0050,    0.0072,    0.0096,    0.0118,    0.0133,    0.0139,    0.0133,    0.0118,    0.0096,    0.0072,    0.0050,    0.0032,    0.0019,
    0.0018,    0.0031,    0.0048,    0.0069,    0.0092,    0.0113,    0.0128,    0.0133,    0.0128,    0.0113,    0.0092,    0.0069,    0.0048,    0.0031,    0.0018,
    0.0016,    0.0027,    0.0042,    0.0061,    0.0081,    0.0100,    0.0113,    0.0118,    0.0113,    0.0100,    0.0081,    0.0061,    0.0042,    0.0027,    0.0016,
    0.0013,    0.0022,    0.0035,    0.0050,    0.0066,    0.0081,    0.0092,    0.0096,    0.0092,    0.0081,    0.0066,    0.0050,    0.0035,    0.0022,    0.0013,
    0.0010,    0.0017,    0.0026,    0.0038,    0.0050,    0.0061,    0.0069,    0.0072,    0.0069,    0.0061,    0.0050,    0.0038,    0.0026,    0.0017,    0.0010,
    0.0007,    0.0011,    0.0018,    0.0026,    0.0035,    0.0042,    0.0048,    0.0050,    0.0048,    0.0042,    0.0035,    0.0026,    0.0018,    0.0011,    0.0007,
    0.0004,    0.0007,    0.0011,    0.0017,    0.0022,    0.0027,    0.0031,    0.0032,    0.0031,    0.0027,    0.0022,    0.0017,    0.0011,    0.0007,    0.0004,
    0.0003,    0.0004,    0.0007,    0.0010,    0.0013,    0.0016,    0.0018,    0.0019,    0.0018,    0.0016,    0.0013,    0.0010,    0.0007,    0.0004,    0.0003],
   [0.0002,    0.0003,    0.0005,    0.0007,    0.0009,    0.0011,    0.0013,    0.0014,    0.0014,    0.0014,    0.0013,    0.0011,    0.0009,    0.0007,    0.0005,    0.0003,    0.0002,
    0.0003,    0.0005,    0.0007,    0.0011,    0.0014,    0.0017,    0.0020,    0.0022,    0.0023,    0.0022,    0.0020,    0.0017,    0.0014,    0.0011,    0.0007,    0.0005,    0.0003,
    0.0005,    0.0007,    0.0011,    0.0016,    0.0021,    0.0026,    0.0030,    0.0033,    0.0035,    0.0033,    0.0030,    0.0026,    0.0021,    0.0016,    0.0011,    0.0007,    0.0005,
    0.0007,    0.0011,    0.0016,    0.0022,    0.0030,    0.0037,    0.0043,    0.0047,    0.0049,    0.0047,    0.0043,    0.0037,    0.0030,    0.0022,    0.0016,    0.0011,    0.0007,
    0.0009,    0.0014,    0.0021,    0.0030,    0.0039,    0.0049,    0.0057,    0.0063,    0.0065,    0.0063,    0.0057,    0.0049,    0.0039,    0.0030,    0.0021,    0.0014,    0.0009,
    0.0011,    0.0017,    0.0026,    0.0037,    0.0049,    0.0061,    0.0071,    0.0078,    0.0080,    0.0078,    0.0071,    0.0061,    0.0049,    0.0037,    0.0026,    0.0017,    0.0011,
    0.0013,    0.0020,    0.0030,    0.0043,    0.0057,    0.0071,    0.0083,    0.0091,    0.0094,    0.0091,    0.0083,    0.0071,    0.0057,    0.0043,    0.0030,    0.0020,    0.0013,
    0.0014,    0.0022,    0.0033,    0.0047,    0.0063,    0.0078,    0.0091,    0.0100,    0.0103,    0.0100,    0.0091,    0.0078,    0.0063,    0.0047,    0.0033,    0.0022,    0.0014,
    0.0014,    0.0023,    0.0035,    0.0049,    0.0065,    0.0080,    0.0094,    0.0103,    0.0106,    0.0103,    0.0094,    0.0080,    0.0065,    0.0049,    0.0035,    0.0023,    0.0014,
    0.0014,    0.0022,    0.0033,    0.0047,    0.0063,    0.0078,    0.0091,    0.0100,    0.0103,    0.0100,    0.0091,    0.0078,    0.0063,    0.0047,    0.0033,    0.0022,    0.0014,
    0.0013,    0.0020,    0.0030,    0.0043,    0.0057,    0.0071,    0.0083,    0.0091,    0.0094,    0.0091,    0.0083,    0.0071,    0.0057,    0.0043,    0.0030,    0.0020,    0.0013,
    0.0011,    0.0017,    0.0026,    0.0037,    0.0049,    0.0061,    0.0071,    0.0078,    0.0080,    0.0078,    0.0071,    0.0061,    0.0049,    0.0037,    0.0026,    0.0017,    0.0011,
    0.0009,    0.0014,    0.0021,    0.0030,    0.0039,    0.0049,    0.0057,    0.0063,    0.0065,    0.0063,    0.0057,    0.0049,    0.0039,    0.0030,    0.0021,    0.0014,    0.0009,
    0.0007,    0.0011,    0.0016,    0.0022,    0.0030,    0.0037,    0.0043,    0.0047,    0.0049,    0.0047,    0.0043,    0.0037,    0.0030,    0.0022,    0.0016,    0.0011,    0.0007,
    0.0005,    0.0007,    0.0011,    0.0016,    0.0021,    0.0026,    0.0030,    0.0033,    0.0035,    0.0033,    0.0030,    0.0026,    0.0021,    0.0016,    0.0011,    0.0007,    0.0005,
    0.0003,    0.0005,    0.0007,    0.0011,    0.0014,    0.0017,    0.0020,    0.0022,    0.0023,    0.0022,    0.0020,    0.0017,    0.0014,    0.0011,    0.0007,    0.0005,    0.0003,
    0.0002,    0.0003,    0.0005,    0.0007,    0.0009,    0.0011,    0.0013,    0.0014,    0.0014,    0.0014,    0.0013,    0.0011,    0.0009,    0.0007,    0.0005,    0.0003,    0.0002]]
