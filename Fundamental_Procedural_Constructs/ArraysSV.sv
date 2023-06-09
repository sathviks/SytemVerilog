`timescale 1ns / 1ps


module ArraysSV;

//Type of declaration 


// fixed size 
    bit arr[8];// it is smillar to     bit arr[7:0];
    bit arr1[] = {}; // commpiler fix size based on LHS side
    
//unique  values    

integer arr3[] = '{ 1,2,3,4}; 

    initial 
    begin
    $display("display : %0p", arr3);
    end


 //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
 
      
//Repitative values    
    
integer arr4[] = '{ 6{1}}; 

    initial 
    begin
    $display("display : %0p", arr4);
    end



//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//

//Default values    
    
integer arr5[10] = '{default : 0 }; // it wil add 0 all the elements of array 


    initial 
    begin
    $display("display : %0p", arr5);
    end


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//


//One more way is we keep array un intialzed

 logic arr6[8]; // default value will be added based datatype and which type [2 or 4 state]

    initial 
    begin
    $display("display : %0p", arr6);// ---------------out put will be X
    end


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//







/*
Repititve operation 
1.for loop
2.foreach 
3.repeat 


This all should be used in procedural block

*/




int rarr[10];
int rarr12[];
int i = 0;
initial 
begin 
    for (i = 0; i <$size(rarr)-1; i++)
       begin
       rarr[i] = i;
       end

    $display("rarr : %0p", rarr);

end

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//



//For Each


 int array[5] = '{100, 200, 300, 400, 500};
  initial begin
    foreach (array[j]) begin
      $display("array[%0d] = %0d", j, array[j]);
    end
  end


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//


//Repeat

initial begin
   repeat(10) begin //this is used in genrator class where we genarate repitated stimulas
   array[i] = i;
   i++;

   end
         $display("array[%0p] = %0p", i, array);

  end

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//


/*

    Common operation with array 
    
    1.Storing one array to another
    
    2. Compare elements of array 

*/


// 1.Storing one array to another:  data type and size should be equal if you store more than size it gves complie error



int array1[5] = '{100, 200, 300, 400, 500};
 int array2[5] ;

initial begin 
array2 = array1;    
$display("%0p", array2);
end


// 2. comparing


 int a[5] = '{1,2,3,4,5};
  int b[5] = '{1,2,3,4,5};
  
  int equals;
  int notequals;
  
  initial begin
    equals = (a == b);
    $display("status equals : %0d",equals);
    
    notequals = (a != b);
    $display("status notequals: %0d",notequals);
    
  end



//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//



/*                DYNAMIC ARRAY                              */


int darry[];
initial begin
    darry = new[5];  // it is like constructor here we us [] insted of ()
    for(int i = 0 ; i < 5 ; i++)begin
    darry[i] =5*i;
    end 
    $display("%0p", darry);
    darry.delete();
    $display("%0p", darry);
    
    //if you try to write agin it will faile complie time error
    
    
    
    darry = new[30]; // to incress size in run time but it will replace older operation --if you try call new it will be empty 
    
 //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//

    
    /*if you want older data then us below one*/
    
    
    darry = new[56](darry);
  //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
    
    end
    
    
/* if it has both dynamic + fixed/static*/
  
  int ff[];
  int fixed[30];


initial begin

 for(int i = 0 ; i < 5 ; i++)begin
    ff[i] =5*i;
    end 
ff = new[30];
ff = fixed;

end 


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//

    integer i;
    
    //size of array
    initial 
    begin
    $display("%0d", $size(arr1));
    $display("%0d", $size(arr));
    //to print all element in arry
    $display("display : %0p", arr);
    end
    
    
    initial begin
     //add values in array
   for (   i = 0; i <$size(arr); i =i+1)
   begin
   arr[i] = i;
   end
    
    
    //print values in array
   for ( i = 0; i <$size(arr); i =i+1)
   begin
   $display("%0d", arr[0]);
   end
   $display("display : %0p", arr);
   end
    
    
endmodule
