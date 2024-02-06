fun is_older(date1: int * int * int, date2: int * int * int) = 
    let 
      val y1 = #3 date1;
      val y2 = #3 date2;
      val m1 = #2 date1;
      val m2 = #2 date2;
      val d1 = #1 date1;
      val d2 = #1 date2;
      val res = 
        if y1<y2 then true
        else if y1=y2 then 
          if m1<m2 then true
          else if m1=m2 then
            if d1<d2 then true
            else false
          else false
        else false;
    in
      res
    end;



fun number_in_month(L: (int * int * int) list, month: int)=
  (*Found the Length method online*)
  if List.length L=0 then 0
  else if #2 (hd(L))= month then 1+number_in_month(tl(L),month)
  else 0+ number_in_month(tl(L),month)



(*Here I will assume that that the months inside the list month are distinct, if they are not disctinct, we would create a function to check this*)
fun number_in_months(L: (int * int * int) list, month: (int) list) = 
  if List.length month =0 then 0
  else number_in_month(L,hd(month)) + number_in_months(L,tl(month))




fun dates_in_month(L:(int*int*int) list,month:int) = 
  if List.length L=0 then []
  else if #2 (hd(L))=month then hd(L) :: dates_in_month(tl(L),month)
  else dates_in_month(tl(L),month)





fun get_nth(L:(string)list,n:int) = 
  let fun helper(L:(string) list,i:int) =   
    if i=n then hd(L)
    else helper(tl(L),i+1)
  in 
    helper(L,1)
  end;



  
fun date_to_string(date: (int*int*int)) = 
  let 
    val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    val month = get_nth(months,#2 date);
    val day = Int.toString (#1 date);
    val year = Int.toString (#3 date);
  in 
    month ^ " " ^ day ^ ", " ^ year

  end;





  fun number_before_reaching(L: int list,target:int) = 
  (*Notice how here I can re use this helper function since I defined it previsouly only in the scope of the function*)
  let 
    fun helper(L: int list, sum:int,i:int) = 
      if sum>=target then i-1
      else helper(tl(L),sum+hd(L),i+1)
  in 
    helper(L,0,1)
  end




fun what_month(day:int) = 
  let 
    val count = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  in 
  (*We can also if we want to get the month in the string re map it to the string list using the get_nth function with the nth number is the value of the function number_before_reaching(count,day)*)
    number_before_reaching(count,day)
  end;




fun month_range(day1:int,day2:int) = 
  let 
    val d1 = what_month(day1);
    val d2 = what_month(day2);
    fun helper(d1:int, d2: int) = 
      if d1>d2 then []
      else d1 :: helper(d1+1,d2)
    val res = if d1<=d2 then helper(d1,d2) else helper(d2,d1);
  in
    res
  end;




fun older(L:(int*int*int) list) = 
  let 
    fun find_min_year(L:(int*int*int) list,min:int) = 
      if List.length L = 0 then min
      else 
        if min > #3 (hd(L)) then find_min_year(tl(L),#3 (hd(L)))
        else find_min_year(tl(L),min)
    fun remove_years(L:(int*int*int) list, min:int) = 
          if List.length L = 0 then []
          else
            if #3 (hd(L))<>min then remove_years(tl(L),min)
            else hd(L) :: remove_years(tl(L),min)
    val Y_min = find_min_year(L,100000);
    val Y_res = remove_years(L,Y_min);
    fun find_min_month(L:(int*int*int) list,min:int) = 
      if List.length L = 0 then min
      else 
        if min > #2 (hd(L)) then find_min_month(tl(L),#2 (hd(L)))
        else find_min_month(tl(L),min)
    fun remove_month(L:(int*int*int) list, min:int) = 
          if List.length L = 0 then []
          else
            if #2 (hd(L))<>min then remove_month(tl(L),min)
            else hd(L) :: remove_month(tl(L),min)
    val M_min = find_min_month(Y_res,100000);
    val M_res = remove_month(Y_res,M_min);
    fun find_min_day(L:(int*int*int) list,min:int) = 
      if List.length L = 0 then min
      else 
        if min > #1 (hd(L)) then find_min_day(tl(L),#1 (hd(L)))
        else find_min_day(tl(L),min)
    fun remove_day(L:(int*int*int) list, min:int) = 
          if List.length L = 0 then []
          else
            if #1 (hd(L))<>min then remove_day(tl(L),min)
            else hd(L) :: remove_day(tl(L),min)
    val D_min = find_min_day(M_res,100000);
    val D_res = remove_day(M_res,D_min);
    val res = hd(D_res)
    in 
      res
    end;
val test1 = older([(1,1,2000),(1,2,1999),(1,1,1999),(1,5,2000),(3,1,1999)])

