fun invertRGBPixel(P: (int*int*int))=
  (255-(#1 P),255-(#2 P),255-(#3 P))
fun rgb2gray(P:(int*int*int)) = 
  ((#1 P)*3 + (#2 P)*6 + (#3 P)*1) div 10
fun gray2bw(g:int) = 
  if g<128 then 0 else 255
fun isBrighter(P1: (int*int*int),P2: (int*int*int)) = 
  rgb2gray(P1)>rgb2gray(P2)
fun invertImage(L:(int*int*int) list) = 
  if List.length L =0 then []
  else   
    invertRGBPixel(hd(L)) :: invertImage(tl(L))
fun rgb2grayImage(L:(int*int*int) list) = 
  if List.length L =0 then []
  else 
    rgb2gray(hd(L)) :: rgb2grayImage(tl(L))
fun brightest(L:(int*int*int) list) = 
  let 
    fun helper(L:(int*int*int) list,max:(int*int*int)) = 
      if List.length L =0 then max
      else if isBrighter(hd(L),max) then helper(tl(L),hd(L))
      else
        helper(tl(L),max)
  in 
    helper(L,hd(L))
  end;
fun countWhite(L: ((int*int*int) list) list) =  
  let 
    fun helper(L: ((int*int*int) list) list, numb: int) =
      if List.length L = 0 then numb
      else
        let
          val temp = hd(L); (*this is also a list*)
          val bri = brightest(temp);
          val gri = rgb2gray(bri);
          val bw = if gray2bw(gri) = 255 then true else false
        in
          if bw = true then helper(tl(L), numb + 1)
          else helper(tl(L), numb)
        end
  in
    helper(L, 0)
  end;
fun shrinkImage(L: int list) = 
  if List.length L = 0 then []
  else
    let 
      val hd1 = hd(L);
      val hd2 = hd(tl(L));
      val x = (hd1+hd2) div 2;
      val res = x :: shrinkImage(tl(tl(L)));
    in 
      res 
    end;
