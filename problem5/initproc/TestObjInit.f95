		MODULE TestObjInit_MOD
		USE REAL_PRECISION
		CONTAINS

		SUBROUTINE TestObjInit(X, OBJ)
		IMPLICIT NONE
		REAL(KIND = R8), DIMENSION(12), INTENT(IN):: X
		REAL(KIND = R8), DIMENSION(1), INTENT(OUT):: OBJ

		!local variables
		INTEGER::i, j, k, ii, N, iflag, iflg, cnt, ierr
		REAL(KIND = R8):: g
		REAL(KIND = R8)::SumXi, pi, m, tol
		REAL(KIND = R8), DIMENSION(12):: lb, ub, XX
		REAL(KIND = R8), DIMENSION(6):: ft, F, w

		N = 12
		m = 6
		pi = 3.14159265359
		SumXi = 0.0

      lb(1:12) = 0.0
		ub(1:12) = 1.0

      F(1:6) = 0.0

		iflag=0
		iflg=0
		cnt=0

		OPEN(88, FILE="weight.dat", STATUS='OLD')
		read(88,*)w
		close(88)

		do k=1,N
			if (X(k)<0.0.or.X(k)>1.0) then
!				write(*,*)'infeasible ',X
				OBJ=1.0e13
				iflag=1
				exit
			end if
		end do
		
		if(iflag<1) then
			do j=6,N,1
				!SumXi = SumXi + (X(j)-0.5)**2 - Cos(20*pi*(X(j)-0.5))
				SumXi = SumXi + (X(j)-0.5)**2 
			end do
			!write(*,*) 'Sum ',SumXi
			!g   = 100 * (7.0 + SumXi)
			g   = SumXi
			!write(*,*) 'g ',g
			F(1) = abs((1+g)*Cos(X(1)*(pi/2))*Cos(X(2)*(pi/2))*Cos(X(3)*(pi/2))*Cos(X(4)*(pi/2))*Cos(X(5)*(pi/2)))
		  	F(2)  = abs((1+g)*Cos(X(1)*(pi/2))*Cos(X(2)*(pi/2))*Cos(X(3)*(pi/2))*Cos(X(4)*(pi/2))*Sin(X(5)*(pi/2)))
		  	F(3)  = abs((1+g)*Cos(X(1)*(pi/2))*Cos(X(2)*(pi/2))*Cos(X(3)*(pi/2))*Sin(X(4)*(pi/2)))
			F(4) = abs((1+g)*Cos(X(1)*(pi/2))*Cos(X(2)*(pi/2))*Sin(X(3)*(pi/2)))
			F(5) = abs((1+g)*Cos(X(1)*(pi/2))*Sin(X(2)*(pi/2)))
			F(6) = abs((1+g)*Sin(X(1)*(pi/2)))
			OBJ=0.0
			do i=1,m
				OBJ=abs(OBJ+w(i)*F(i))
			end do
		end if

		END SUBROUTINE TestObjInit

		END MODULE TestObjInit_MOD

