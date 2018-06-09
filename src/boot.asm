; boot16.asm  FAT16 bootstrap for real mode image or loader
; Version 1.0, Jul 5, 1999
; Sample code
; by John S. Fine  johnfine@erols.com
; I do not place any restrictions on your use of this source code
; I do not provide any warranty of the correctness of this source code
;_____________________________________________________________________________
;
; Documentation:
;
; I)    BASIC features
; II)   Compiling and installing
; III)  Detailed features and limits
; IV)   Customization
;_____________________________________________________________________________
;
; I)    BASIC features
;
;    This boot sector will load and start a real mode image from a file in the
; root directory of a FAT16 formatted partition or (maybe) floppy.
;
;    Inputs:
; DL = drive number
;
;    Outputs:
; The boot record is left in memory at 7C00 and the drive number is patched
; into the boot record at 7C24.
; SS = DS = 0
; BP = 7C00
; DL = drive number
;_____________________________________________________________________________
;
; II)   Compiling and installing
;
;  To compile, use NASM
;
;  nasm boot16.asm -o boot16.bin
;
;  Then you must copy the first three bytes of BOOT16.BIN to the first three
;  bytes of the volume and copy bytes 0x3E through 0x1FF of BOOT16.BIN to
;  bytes 0x3E through 0x1FF of the volume.  Bytes 0x3 through 0x3D of the
;  volume should be set by a FAT16 format program and should not be modified
;  when copying boot16.bin to the volume.
;
;  If you use my PARTCOPY program to install BOOT16.BIN on D:, the
;  commands are:
;
;  partcopy boot16.bin 0 3 -ad
;  partcopy boot16.bin 3e 1c2 -ad 3e
;
;  Please read partcopy documentation and use it carefully.  Careless use
;  could overwrite important parts of your hard drive.
;
;  Before using partcopy to modify any part of your hard drive you should
;  make a bootable floppy and put partcopy.exe on that floppy and put
;  backup copies of key parts of your hard drive into files on that floppy.
;
;  partcopy -h0 0 200 A:MBR.BIN
;  partcopy -ac 0 200 A:PART_C.BIN
;  partcopy -ad 0 200 A:PART_D.BIN
;
;  If you are trying BOOT16 on a secondary partition of your hard drive, you
;  may need a multi-boot program such as my SMBMBR example.
;
;  You can find PARTCOPY and SMBMBR and links to NASM on my web page at
;  http://www.erols.com/johnfine/
;_____________________________________________________________________________
;
; III)  Detailed features and limits
;
;   Most of the limits are stable characteristics of the volume.  If you are
; using boot16 in a personal project, you should check the limits before
; installing boot16.  If you are using boot16 in a project for general
; distribution, you should include an installation program which checks the
; limits automatically.
;
; CPU:  Supports any 8088+ CPU.
;
; Volume format:  Supports only FAT16.
;
; Sector size:  Supports only 512 bytes per sector.
;
; Drive/Partition:  Supports whole drive or any partition of any drive number
; supported by INT 13h.
;
; Diskette parameter table:  This code does not patch the diskette parameter
; table.  If you boot this code from a diskette that has a different number of
; sectors per track than the default initialized by the BIOS then the failure
; to patch that table may be a problem.
;
; File position:  The file name may be anywhere in the root directory and the
; file may be any collection of clusters on the volume.  There are no
; contiguity requirements.
;
; Track boundaries:  Transfers are NOT split on track boundaries.  Many BIOS's
; require that the caller split floppy transfers on track boundaries.  This
; omission usually makes this code unacceptable for floppies.  FAT16 is not
; often used for floppies anyway.
;
; 64Kb boundaries:  Transfers are NOT split on 64Kb boundaries.  Many BIOS's
; require that the caller split floppy transfers on track boundaries.
;
; Cluster boundaries:  Transfers are NOT merged across cluster boundaries
; On some systems, this would have significantly reduced load time.  (See
; boot12.asm).
;
; Cluster 2 limit:  Cluster 2 must start before sector 65536 of the volume.
; This is very likely because only the reserved sectors (usually 1) and
; the FAT's (two of up to 128 sectors each) and the root directory (usually
; 32 sectors) precede cluster 2.
;
; Track limit:  No limit.  Unlike many other 8088 bootsectors, this one
; supports over 65536 tracks.  It supports up to the limit of the unextended
; INT 13h interface (1024 cylinders x 255 heads x 63 sectors).
;
; Memory boundaries:  Transfers to any paragraph boundary.
;
; Memory use:  Everything must fit in real mode accessible memory.  The
; FAT and the image must not overlap.  Either may overlap the root.
;
; Root directory size:  Up to 2048 root directory entries.  Most FAT16
; volumes have 512 root directory entries.
;_____________________________________________________________________________
;
; IV)   Customization
;
;   The memory usage can be customized by changing the _SEG variables (see
; directly below).
;
;   The file name to be loaded and the message displayed in case of error
; may be customized (see end of this file).
;
;   The ouput values may be customized.
;
;   You might want to improve floppy support.  See boot12.asm for comparison.
;
;   Change whatever else you like.  The above are just likely possibilities.
;_____________________________________________________________________________

%define ROOT_SEG	0x800
%define FAT_SEG		0x800
%define IMG_SEG		0x2800

; The following %define directives declare the parts of the FAT16 "DOS BOOT
; RECORD" that are used by this code, based on BP being set to 7C00.
;
%define	sc_p_clu	bp+0Dh		;byte  Sectors per cluster
%define	sc_b4_fat	bp+0Eh		;word  Sectors (in partition) before FAT
%define	fats		bp+10h		;byte  Number of FATs
%define dir_ent		bp+11h		;word  Number of root directory entries
%define	sc_p_fat	bp+16h		;word  Sectors per FAT
%define sc_p_trk	bp+18h		;word  Sectors per track
%define heads		bp+1Ah		;word  Number of heads
%define sc_b4_prt	bp+1Ch		;dword Sectors before partition
%define drive		bp+24h		;byte  Drive number

	org	0x7C00

entry:
	jmp	short begin
	nop

; Skip over the data portion of the "DOS BOOT RECORD".  The install method
; must merge the code from this ASM with the data put in the boot record
; by the FAT16 formatter.
;
	times 0x3B db 0

begin:
	xor	ax, ax
	mov	ds, ax
	mov	ss, ax
	mov	sp, 0x7C00
	mov	bp, sp
	mov	[drive], dl	;Drive number

	mov	al, [fats]	;Number of FATs
	mul	word [sc_p_fat]	; * Sectors per FAT
	add	ax, [sc_b4_fat]	; + Sectors before FAT
	xchg	ax, di		;DI = Sector of Root directory

	mov	bx, [dir_ent]	;Max root directory entries
	mov	cl, 4
	dec	bx
	shr	bx, cl
	inc	bx		;BX = Length of root in sectors

	mov	ax, ROOT_SEG	;Segment for root directory
	mov	es, ax
	call	read_16		;Read root directory
	push	di		;Sector of cluster two
%define sc_clu2 bp-2		;Later access to the word just pushed is via bp

	mov	dx, [dir_ent]	;Number of directory entries
	xor	di, di		;Point at first directory entry

search:
	dec	dx		;Any more directory entries?
	js	error		;No
	mov	si, filename	;Name we are searching for
	mov	cx, 11		;11 characters long
	lea	ax, [di+0x20]	;Precompute next entry address
	push	ax
	repe cmpsb		;Compare
	pop	di
	jnz	search		;Repeat until match

	mov	si, IMG_SEG	;Segment for image
	push	si		;  segment for retf
	push	bx		;  zero offset for retf

	push word [es:di-6]	;Starting cluster number

   %if FAT_SEG-ROOT_SEG
	mov	ax, FAT_SEG	;Segment for FAT
	mov	es, ax
   %endif

	mov	di, [sc_b4_fat]	;Sector number of FAT
	mov	bl, [sc_p_fat]	;Length of FAT (or zero if FAT is 256)
	cmp	bl, 0x81	;If it is 1 through 0x80
	js	.1		;  then read it in one chunk
	push	bx		;  but for 0, or 0x81 through 0xFF
	mov	bl, 0x80	;  read 0x80 sectors first.
	call	read_16
	pop	bx
	sub	bl, 0x80	;Remainder after first 0x80 sectors
	mov	ax, FAT_SEG+0x1000  ;Segment for second part of FAT
	mov	es, ax
.1:
	call	read_16

next:	;Loop for all clusters
	pop	ax		;Cluster number
	cmp	ax, byte -0x12	;End of file?
	jae	eof		; Yes
	mov	di, ax
	shl	di, 1		;A two-byte entry per cluster
	mov	dx, FAT_SEG	;Assume first half of FAT
	jnc	.1		;  It is first
	mov	dh, (FAT_SEG/256)+8  ;Second half of FAT
.1:	mov	ds, dx
	push	word [di]	;Cluster number for next time
	
	dec	ax
	dec	ax		;Current cluster minus two
	mov	bl, [sc_p_clu]
	mul	bx		; * sectors per cluster
	add	ax, [sc_clu2]	; + sector number of cluster two
	adc	dl, dh		;Allow 24-bit result

	xchg	ax, di		;DX:DI = sector number
	mov	es, si		;ES = destination segment
	mov	ax, bx		;AX = cluster size in sectors
	mov	cl, 5
	shl	ax, cl		;AX = cluster size in paragraphs
	add	si, ax		;Precompute next segment
	
	call	read_32		;Read one cluster
	jmp	short next	

eof:	retf

error:	mov	si, errmsg	;Same message for all detected errors
	mov	ax, 0xE0D	;Start message with CR
	mov	bx, 7
.1:	int	10h
	ss lodsb
	test	al, al
	jnz	.1
	xor	ah, ah
	int	16h		;Wait for a key
	int	19h		;Try to reboot

read_16:
	xor	dx, dx

read_32:
;
; Input:
;    dx:di = sector within partition
;    bl    = sector count (max 0x80)
;    es    = destination segment
;
; The sector number is converted from a partition-relative to a whole-disk
; (LBN) value, and then converted to CHS form, and then the sectors are read
; into ES:0.
;
; Output:
;    di = input di + input bx
;    bx = 0
;    dl = drive
;    si, bp and seg regs unchanged
;    other registers modified

	lea	ax, [di+bx]		;Compute di+bx (needed by two caller's
	push	ax			;  of read_16)

	add	di, [sc_b4_prt]		;Convert to LBN
	adc	dx, [sc_b4_prt+2]

	xchg	ax, dx			;AX = (high) LBN
	cwd
	div	word [sc_p_trk]		; / Sectors per track
	xchg	ax, di			;AX = (low) LBN   ;DI = (high) track
	div	word [sc_p_trk]		;AX = (low) track ;DX = sector-1
	inc	dx
	mov	cl, dl			;CL = sector
	mov	dx, di			;DX = (high) track
	div	word [heads]		; / Number of heads
	mov	dh, dl			;DH = head

	mov	ch, al			;CH = (low) cylinder
	ror	ah, 1			;rotate (high) cylinder
	ror	ah, 1
	add	cl, ah			;CL = combine sector, (high) cylinder
	mov	dl, [drive]		;DL = Drive number
	xchg	ax, bx			;AL = Sector count
	mov	ah, 2			;AH = Read command
	xor	bx, bx			;ES:BX = address
	int	13h			;Do it
	jc	error
	pop	di			;DI = Input DI + Input BX
	ret

errmsg	db	10,"Error Executing FAT16 bootsector",13
	db	10,"Press any key to reboot",13,10,0

size	equ	$ - entry
%if size+11+2 > 512
  %error "code is too large for boot sector"
%endif
	times	(512 - size - 11 - 2) db 0

filename db	"PORTLAND   "		;11 byte name
	db	0x55, 0xAA		;2  byte boot signature
