PROGRAM randomHDR  
  IMPLICIT NONE
  INTEGER, PARAMETER :: ns = 10000000,num_bins=10
  INTEGER :: i,j,k0, counts(num_bins)
  INTEGER :: ix(0:255)  
  REAL(8) :: rand1,rand2,suma, avg 
  REAL(8) :: expected, chi_square,bin_width
  REAL(8) :: rr250 = dfloat(1)/(dfloat(2147483647)+dfloat(1))
  REAL(8) :: suma_xy, suma_x, suma_y, suma_x2, suma_y2, corr
  
!   real*8 :: r250  = dfloat(1)/dfloat(2147483647)
  

    k0=0
    !----reading 
    open(2,file='seeds.dat')
    read (2,*) 	
    do  i=0,255
        read (2,*) ix(i)
    end do
    close (2)
    !-----

    
    !=========================================================
    ! Averaged test
    !=========================================================
    suma=0.0d0
    do i = 1, ns
        !---random number generation
        k0=and((k0+1),255)
        ix(k0)=xor(ix(and(k0-103,255)),ix(and(k0-250,255)))
        rand1=rr250*ix(k0)
        !---end random number generation
        suma = suma + rand1
    end do
    avg = suma / real(ns, 8)
    print *, 'Averaged (it should be very close to 0.5): ', avg
    
    
    !=========================================================
    ! Chi-square test
    !=========================================================
    counts = 0
    bin_width = 1.0 / real(num_bins)
    DO i = 1, ns
        !===
        k0=and((k0+1),255)
        ix(k0)=xor(ix(and(k0-103,255)),ix(and(k0-250,255)))
        rand1=rr250*ix(k0)
        !===
        j = int(rand1 / bin_width) + 1
        if (j > num_bins) j = num_bins
        counts(j) = counts(j) + 1            
    END DO
    ! Chi-square
    expected = real(ns,8) / real(num_bins, 8)
    chi_square = 0.0
    DO i = 1, num_bins
        chi_square = chi_square + ((counts(i) - expected)**2) / expected
    END DO
    PRINT*, "Chi2: ", chi_square,',  rand= ',rand1
    
    !=========================================================
    ! self-correlation test
    !=========================================================
    suma_xy = 0.0d0
    suma_x = 0.0d0
    suma_y = 0.0d0
    suma_x2 = 0.0d0
    suma_y2 = 0.0d0
    
    !===== Initial random number
    k0=and((k0+1),255)
    ix(k0)=xor(ix(and(k0-103,255)),ix(and(k0-250,255)))
    rand1=rr250*ix(k0)
    !=====
    suma = 0.0d0
    do i = 1, ns
        !===
        k0=and((k0+1),255)
        ix(k0)=xor(ix(and(k0-103,255)),ix(and(k0-250,255)))
        rand2=rr250*ix(k0)
        !===
        suma_xy = suma_xy + rand1 * rand2
        suma_x = suma_x + rand1
        suma_y = suma_y + rand2
        suma_x2 = suma_x2 + rand1 * rand1
        suma_y2 = suma_y2 + rand2 * rand2
        rand1 = rand2
    end do

    ! correlation
    corr = (suma_xy - suma_x * suma_y /real(ns,8))&
            /dsqrt( (suma_x2 - suma_x*suma_x/ real(ns,8))*(suma_y2-suma_y*suma_y/real(ns,8)) )

    write(*,'(A,f15.8)') 'Correlation (it should be almost zero): ', corr
    
END PROGRAM randomHDR

