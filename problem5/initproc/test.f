      program test

		use REAL_PRECISION
		real(KIND = R8), dimension(12):: x, lb, ub
		integer i;
	
		do i=1,12
			lb(i)=0
			ub(i)=1
			x=0.5
		end do

      call nomad( 12 , 1 , x , lb , ub , 2000 , 2 )


      end 

      subroutine bb(xx,fx)
!				use TestObj_MOD
				use TestObjInit_MOD
				use REAL_PRECISION
				implicit none

				real(kind = R8), dimension(12), intent(IN) :: xx
				real(kind = R8), dimension(1), intent(OUT):: fx
	
				call TestObjInit(xx, fx)
	      	return
		end
