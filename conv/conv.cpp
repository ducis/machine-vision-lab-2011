#include <windows.h>
#include <gdiplus.h>
#include <cstring>
#include <memory>
#include <iostream>
#include <cassert>
#include <algorithm>
#include <iterator>

using namespace Gdiplus;
int GetEncoderClsid(const WCHAR* format, CLSID* pClsid)
{
   UINT  num = 0;          // number of image encoders
   UINT  size = 0;         // size of the image encoder array in bytes

   ImageCodecInfo* pImageCodecInfo = NULL;

   GetImageEncodersSize(&num, &size);
   if(size == 0)
      return -1;  // Failure

   pImageCodecInfo = (ImageCodecInfo*)(malloc(size));
   if(pImageCodecInfo == NULL)
      return -1;  // Failure

   GetImageEncoders(num, size, pImageCodecInfo);

   for(UINT j = 0; j < num; ++j)
   {
      if( wcscmp(pImageCodecInfo[j].MimeType, format) == 0 )
      {
         *pClsid = pImageCodecInfo[j].Clsid;
         free(pImageCodecInfo);
         return j;  // Success
      }    
   }

   free(pImageCodecInfo);
   return -1;  // Failure
}

int main(int argc, char **argv){
	GdiplusStartupInput gdiplusStartupInput;
	ULONG_PTR gdiplusToken;
	assert(argc >= 2);
	GdiplusStartup(&gdiplusToken, &gdiplusStartupInput, NULL);

	
	{
		typedef unsigned char pixel_type;
		wchar_t buf[256];
		mbstowcs(buf,argv[1],250);
		if(argc>2){
			UINT w=0,h=0;
			std::cin>>w>>h;
			assert(w&&h);
			std::auto_ptr<Bitmap> bmp( new Bitmap(w,h,PixelFormat8bppIndexed) );
			//{
			//	std::auto_ptr<Bitmap> tmplt( new Bitmap(L"__bitmap__format__") );
			//	UINT size = tmplt->GetPaletteSize();
			//	ColorPalette* palette = (ColorPalette*)malloc(size);
			//	Status s = tmplt->GetPalette(palette, size);
			//	assert(Ok == s);
			//	free(palette);
			//	s = bmp->SetPalette(palette);
			//	std::cout<<s;
			//	assert(Ok == s);
			//}
			BitmapData d;
			Status s = bmp->LockBits(NULL,ImageLockModeWrite,bmp->GetPixelFormat(),&d);
			assert(Ok == s);
			assert(d.Width == w);
			assert(d.Height == h);
			assert(d.PixelFormat == PixelFormat8bppIndexed);
			char *pr = (char*)d.Scan0;
			for( unsigned r = 0; r<h; ++r ){
				pixel_type *begin = (pixel_type*)pr;
				pixel_type *end = begin + w;
				for( pixel_type *p = begin; p != end; ++p ){
					int i = 0;
					std::cin>>i;
					*p = i;
				}
				pr+=d.Stride;
			}
			bmp->UnlockBits(&d);
			CLSID bmpClsid;
			GetEncoderClsid(L"image/bmp", &bmpClsid);
			bmp->Save(buf,&bmpClsid,NULL);
			{
				FILE *dest = fopen(argv[1],"rb+");
				FILE *src = fopen("__bitmap__format__","rb");
				assert(src);
				assert(dest);
				char b[2048];
				int f = 35, l = 1078;
				fseek(src,f,SEEK_SET);
				fseek(dest,f,SEEK_SET);
				fread(b,1,l-f,src);
				fwrite(b,1,l-f,dest);
				fclose(dest);
				fclose(src);
			}
		}else{
			std::auto_ptr<Bitmap> bmp( new Bitmap(buf) );
			std::cout<<bmp->GetWidth()<<' '<<bmp->GetHeight()<<"\n";
			assert(bmp->GetPixelFormat() == PixelFormat8bppIndexed);
			BitmapData d;
			Status s = bmp->LockBits(NULL,ImageLockModeRead,bmp->GetPixelFormat(),&d);
			assert(Ok == s);
			assert(d.Width == bmp->GetWidth());
			assert(d.Height == bmp->GetHeight());
			assert(bmp->GetPixelFormat() == d.PixelFormat);
			char *pr = (char*)d.Scan0;
			for( unsigned r = 0; r<d.Height; ++r ){
				pixel_type *p = (pixel_type*)pr;
				std::copy(p,p+d.Width,std::ostream_iterator<unsigned>(std::cout,"\t"));
				std::cout<<'\n';
				pr += d.Stride;
			}
			bmp->UnlockBits(&d);
		}
	}

	GdiplusShutdown(gdiplusToken);
	return 0;
}
