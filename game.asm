#####################################################################
#
# CSCB58 Winter 2021 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Raymond Kiguru, 100-658-6366, kigurura
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8 (update this as needed)
# - Unit height in pixels: 8 (update this as needed)
# - Display width in pixels: 256 (update this as needed)
# - Display height in pixels: 256 (update this as needed)
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4 (choose the one the applies)
#
# Which approved features have been implemented for milestone 4?
# (See the assignment handout for the list of additional features)
# 1. (fill in the feature, if any)
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
# ... (add more if necessary)
#
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here). Make sure we can view it!
#
# Are you OK with us sharing the video with people outside course staff?
# - yes / no / yes, and please share this project github link as well!
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################
################################################################################
# MIPS SUIT GUNB58
################################################################################

################################################################################
# DEFINE CONSTANTS
################################################################################

# MIPS CODES ___________________________________________________________________

.eqv	PRT_REG	0x00000001	#  1 print the value in $a0 to terminal
.eqv	PRT_VAR	0x00000004	#  4 print a provided variable
.eqv	END	0x0000000A	# 10 end the program
.eqv	RNG_RNG	0x0000002A	# 42 get ranged random number
.eqv	SLP	0x00000020	# 32 sleep for a given duration

.eqv	WRD_LEN	0x00000004	# length of a word

# SCREEN DISPLAY _______________________________________________________________

.eqv	SCR_ADR	0x10008000	# base address for the screen's framebuffer
# .eqv	SCR_X	0x00000020	# number of units the screen is wide
# .eqv	SCR_Y	0x00000020	# number of units the screen is tall
.eqv	SCR_X	0x00000040	# number of units the screen is wide
.eqv	SCR_Y	0x00000040	# number of units the screen is tall

# render offset codes [32X] (p(plus), m(minus), _(neither; 0))            UPDATE
# .eqv	Y_0X_0	0x0000
# .eqv	Y_0Xp1	0x0004
# .eqv	Y_0Xp2	0x0008

# .eqv	Yp1Xm2	0x0078
# .eqv	Yp1Xm1	0x007C
# .eqv	Yp1X_0	0x0080
# .eqv	Yp1Xp1	0x0084
# .eqv	Yp1Xp2	0x0088

# .eqv	Yp2Xm2	0x00F8
# .eqv	Yp2Xm1	0x00FC
# .eqv	Yp2X_0	0x0100
# .eqv	Yp2Xp1	0x0104
# .eqv	Yp2Xp2	0x0108

# .eqv	Yp3Xm1	0x017C
# .eqv	Yp3X_0	0x0180
# .eqv	Yp3Xp1	0x0184

# render offset codes [64X] (p(plus), m(minus), _(neither; 0))            UPDATE
.eqv	Y_0X_0	0x0000
.eqv	Y_0Xp1	0x0004
.eqv	Y_0Xp2	0x0008

.eqv	Yp1Xm2	0x00F8
.eqv	Yp1Xm1	0x00FC
.eqv	Yp1X_0	0x0100
.eqv	Yp1Xp1	0x0104
.eqv	Yp1Xp2	0x0108

.eqv	Yp2Xm2	0x01F8
.eqv	Yp2Xm1	0x01FC
.eqv	Yp2X_0	0x0200
.eqv	Yp2Xp1	0x0204
.eqv	Yp2Xp2	0x0208

# for shadows [32X] (p(plus), m(minus), _(neither; 0))                    UPDATE
# .eqv	Y_0Xp3	0x000C

# .eqv	Yp1Xm3	0x0074
# .eqv	Yp1Xp3	0x008C

# .eqv	Yp2Xm3	0x00F4
# .eqv	Yp2Xp3	0x010C

# for horns [32X] (p(plus), m(minus), _(neither; 0))                      UPDATE
# .eqv	Yp3Xm2	0x0178

# for shadows [64X] (p(plus), m(minus), _(neither; 0))                    UPDATE
.eqv	Y_0Xp3	0x000C

.eqv	Yp1Xm3	0x00F4
.eqv	Yp1Xp3	0x010C

.eqv	Yp2Xm3	0x01F4
.eqv	Yp2Xp3	0x020C

.eqv	Yp3Xm3	0x02F4
.eqv	Yp3Xm1	0x02FC
.eqv	Yp3X_0	0x0300
.eqv	Yp3Xp1	0x0304

.eqv	Yp4Xm2	0x03F8

# for horns [64X] (p(plus), m(minus), _(neither; 0))                      UPDATE
.eqv	Yp3Xm2	0x02F8

# PLAYER INPUT _________________________________________________________________
.eqv	KBD_ADR	0xFFFF0000	# keystroke event logger
.eqv	KBD_W	0x00000077	# hex value for ascii code corresponding to 'w'
.eqv	KBD_A	0x00000061	# hex value for ascii code corresponding to 'a'
.eqv	KBD_S	0x00000073	# hex value for ascii code corresponding to 's'
.eqv	KBD_D	0x00000064	# hex value for ascii code corresponding to 'd'

# ASSETS _______________________________________________________________________

# high-z(aku) colour palette
.eqv	C_ZK_EY	0x00E91E63	# eye pupil
.eqv	C_ZK_SC	0x00004D40	# sclera
.eqv	C_ZK_PP	0x00827717	# pipe
.eqv	C_ZK_DK 0x001B5E20	# dark
.eqv	C_ZK_LT 0x0033691E	# light
.eqv	C_ZK_MT	0x00558B2F	# mouthpiece

# gunb58 colour palette
.eqv	C_GD_EY	0x00CDDC39	# eye
.eqv	C_GD_CK 0x00607D8B	# cheek
.eqv	C_GD_CR 0x002196F3	# crest
.eqv	C_GD_HR 0x00FFC107	# horns
.eqv	C_GD_AC 0x003F51B5	# accents
.eqv	C_GD_NK 0x009E9E9E	# neck
.eqv	C_GD_DK 0x00304FFE	# dark
.eqv	C_GD_LT 0x00FFFFFF	# light

# explosion orange
.eqv	C_EXP_1 0x00FD8003	# the primary colour to render explosions
.eqv	C_EXP_2 0x00D5520A	# the secondary colour to render explosions

# GAME FACTORS _________________________________________________________________

.eqv	PLY_DAT	0x00000014	# player data size (x_pos, y_pos, radius, move)
.eqv	PLY_X	0x00000000	# player's x pos offset in pseudo-struct
.eqv	PLY_Y	0x00000004	# player's y pos offset in pseudo-struct
.eqv	PLY_R	0x00000008	# player's radius offset in pseudo-struct
.eqv	PLY_MOV	0x0000000C	# player's ongoing move offset in pseudo-struct
.eqv	PLY_CLD	0x00000010	# player's collision indicator member offset
.eqv	PLY_RAD	0x00000002	# player's radius for calculating offsets, etc.
.eqv	PLY_DIM	0x00000004	# player's square radius for collision detection

.eqv	MAX_ENM	0x00000003	# max number of contemporaneous enemies
.eqv	ENM_DAT 0x00000010	# enemy data size (x_pos, y_pos, radius, x1_pos)
.eqv	ENM_X	0x00000000	# offset of enemy x_pos in pseudo-struct
.eqv	ENM_Y	0x00000004	# offset of enemy y_pos in pseudo-struct
.eqv	ENM_R	0x00000008	# offset of enemy radii in pseudo-struct
.eqv	ENM_X1	0x0000000C	# offset of prev enemy x_pos in pseudo-struct
.eqv	SPW_STG	0x00000040	# enemy spawn stagger

.eqv	ZK_RAD	0x00000002	# high-z(aku) enemy size (radius)
.eqv	ZK_DIM	0x00000004	# high-z(aku) enemy size (diameter)

.eqv	EXPL_X	0x00000000
.eqv	EXPL_Y	0x00000004
.eqv	EXPL_X1	0x00000008
.eqv	EXPL_Y1	0x0000000C

.eqv	SLP_DUR	0x000001F4	# sleep time per tick

# QUALITY OF LIFE ______________________________________________________________

.eqv	DNE	0xFFFFFFFF	# Does Not Exist: safe empty / error state index

# DEBUG VARIABLES ______________________________________________________________

.eqv	D_SL_DR	0x00000011	# sleep time per debug step

################################################################################
# DECLARE VARIABLES
################################################################################

.data

# DEBUG ________________________________________________________________________

Dmlstn:	.asciiz	"MILESTONE\n"		# constant to print if statement reached
Dk_enm:	.asciiz "Kil Enemy Milestone\n"	# constant to print during enemy destroy
Dm_enm:	.asciiz "Mov Enemy Milestone\n"	# constant to print during enmy movement
Dg_enm:	.asciiz "Gen Enemy Milestone\n"	# constant to print during new enemy gen
Dr_enm:	.asciiz "Rnd Enemy Milestone\n"	# constant to print during new enemy gen
Denm_r:	.asciiz	" enemy radius:"	# value tag
Denm_x:	.asciiz " enemy x pos:"		# value tag
Denm_o:	.asciiz " enemy x1 pos:"	# value tag
Denm_y:	.asciiz " enemy y pos:"		# value tag

Dcolsn:	.asciiz	"COLLISION!\n"		# print constant on collision detection

# PROGRAM ______________________________________________________________________

# PLAYER
player:	.word	0, 0, 0, 0, 0	# player data struct

expl:	.word	DNE, DNE	# explosion render position

# ENEMIES
# number of living enemies and their indices
n_enms:	.word	0		# total number of living

################################################################################
# MIPS SUIT GUNB58
################################################################################

.text
.globl main
main:
	# SETUP
	li	$s6,	ENM_DAT	# load frequently used enemy struct size

	la	$s0,	player
	li	$s1,	PLY_RAD	# load player's radius due to sprite offset
	addi	$s1,	$s1,	2	# offer a small margin on left
	sw	$s1,	PLY_X($s0)	# save position as starting player x pos
	li	$s1,	SCR_Y	# load screen height to put player in the middle
	srl	$s1,	$s1,	1	# divide screen height by 2
	sw	$s1,	PLY_Y($s0)	# store player's y pos as screen middle

	# GAME LOOP
	GME_LP:		# main game loop
	# la	$a0,	Dmlstn	#                                          DEBUG
	# jal	dbg_prt		#                                          DEBUG

	# li	$v0,	SLP
	# li	$a0,	SLP_DUR # pause tick for SLP_DUR milliseconds
	# syscall

	li	$v0,	SLP
	li	$a0,	D_SL_DR # pause tick for D_SL_DR milliseconds      DEBUG
	syscall

	# DESPAWN DEAD ENEMIES _________________________________________________
	lw	$s2,	n_enms		# number of living enemies (for bg_kil)

	move	$s0,	$s2		# number of living enemies
	addi	$s0,	$s0,	-1	# enemy idx offset for first stack frame
	mul	$s0,	$s0,	$s6	# multiply for ptr-diff offset of first
	add	$s0,	$sp,	$s0	# first enemy addr = array base + offset

	enm_kil:	# enemy movement loop (iterate over live enemies)
	blt	$s0,	$sp,	enm_kil_ed	# loop termination condition

	lw	$s1,	ENM_X($s0)	# load enemy's x position from struct
	lw	$s3,	ENM_R($sp)	# store radius for calculating dist from
					# screen border to kill (x + r + 1 < 0):
					# r  r  x  r  r  -1  0(first pxl column)
	add	$s4,	$s1,	$s3	# get pos of rightmost side of the enemy
	addi	$s4,	$s4,	1	# must be >= 1 px away from edge for old
	bgez	$s4,	ed_kil		# enemy still in game field; do not kill

	bg_kil:	# pop dead from stack until live found, then swap with dead s0
	bgt	$sp,	$s0,	ed_kil	# enemy to kill is last alive, his stack
					# > frame has been popped by bg_kil loop

	addi	$s2,	$s2,	-1	# decrement the number of living enemies

	lw	$s1,	ENM_X($sp)	# recycle s1 for stack-top enemy's x pos
	lw	$s3,	ENM_R($sp)	# store radius for calculating dist from
					# screen border to kill (x + r + 1 < 0):
					# r  r  x  r  r  -1  0(first pxl column)
	add	$s4,	$s1,	$s3	# get pos of rightmost side of the enemy
	addi	$s4,	$s4,	1	# must be >= 1 px away from edge for old
	bltz	$s4,	tp_ded		# stack-top enemy also dead; do not copy

	tp_alv:	# stack-top enemy is alive; copy his data to s0 dead enemy index
	sw	$s1,	ENM_X($s0)	# assign stack-top enemy x pos to s1 idx
	lw	$s1,	ENM_Y($sp)	# recycle s1 for stack-top enemy's y pos
	sw	$s1,	ENM_Y($s0)	# assign stack-top enemy y pos to s1 idx
	lw	$s1,	ENM_R($sp)	# recycle s1 for stack-top enemy radius
	sw	$s1,	ENM_R($s0)	# assign stack-top enemy radius to s1
	lw	$s1,	ENM_X1($sp)	# recycle s1 for stack-top enemy radius
	sw	$s1,	ENM_X1($s0)	# assign stack-top enemy radius to s1

	addi	$sp,	$sp,	ENM_DAT	# pop this enemy's stack frame
	b	ed_kil			# index recycled; end iteration

	tp_ded:	# stack-top enemy dead; don't copy data to idx s0 enemy, but pop
	addi	$sp,	$sp,	ENM_DAT	# pop this enemy's stack frame
	b	bg_kil

	ed_kil: 

	addi	$s0,	$s0,	-ENM_DAT# move enemy index pointer up the stack
	b	enm_kil	# re-iterate until all enemies moved
	enm_kil_ed:	# end enemy movement

	sw	$s2,	n_enms	#store the new number of live enemies
	# MOVE PLAYER __________________________________________________________
	# GET PLAYER INPUT
	la	$s0,	KBD_ADR	# load keystroke logger addr to check if pressed
	lw	$s1,	($s0)	# load state of keystroke detection
	la	$s2,	player	# load the player to be operated upon
	bne	$s1,	1,	no_ply_mov	# no keystroke detected; skip
	# PROCESS PLAYER INPUT
	lw	$s1,	WRD_LEN($s0)	# load player move direction from memory
	sw	$s1,	PLY_MOV($s2)	# store player moved direction for clear
	lw	$s3,	PLY_X($s2)	# load player current x position
	lw	$s4,	PLY_Y($s2)	# load player current y position
	li	$s5,	PLY_RAD		# load plyr radius to calc border offset
	beq	$s1,	KBD_W,	ply_mov_w	# process movement in up dir
	beq	$s1,	KBD_A,	ply_mov_a	# process movement in left dir
	beq	$s1,	KBD_S,	ply_mov_s	# process movement in down dir
	beq	$s1,	KBD_D,	ply_mov_d	# process movement in right dir
	no_ply_mov:	# absent / invalid player movement; do not move
	sw	$zero,	PLY_MOV($s2)	# set player movement indicator to 0
	b	ply_mov_ed	# cease all movement activity
	ply_mov_w:	# move player in up direction if not at screen border
	addi	$s1,	$s5,	1		# add horn offset to max height
	ble	$s4,	$s1,	no_ply_mov	# at screen top; do not move
	addi	$s4,	$s4,	-1		# move player avatar up
	b	ply_mov_prc			# player pos update complete
	ply_mov_a:	# move player in left direction if not at screen border
	ble	$s3,	$s5,	no_ply_mov	
	addi	$s3,	$s3,	-1
	b	ply_mov_prc
	ply_mov_s:	# move player in down direction if not at screen border
	li	$s1,	SCR_Y	# recycle s1 with screen y dimension for RHS max
	addi	$s1,	$s1,	-PLY_RAD	# give RHS max player rad offset
	addi	$s1,	$s1,	-1		# give end exclusive offset of 1
	bge	$s4,	$s1,	no_ply_mov
	addi	$s4,	$s4,	1
	b	ply_mov_prc
	ply_mov_d:	# move player in right direction if not at screen border
	li	$s1,	SCR_X	# recycle s1 with screen x dimension for RHS max
	addi	$s1,	$s1,	-PLY_RAD	# give RHS max player rad offset
	addi	$s1,	$s1,	-1		# give end exclusive offset of 1
	bge	$s3,	$s1,	no_ply_mov
	addi	$s3,	$s3,	1
	b	ply_mov_prc			# unneeded but uniform semantics
	ply_mov_prc:
	sw	$s3,	PLY_X($s2)	# store new player x position
	sw	$s4,	PLY_Y($s2)	# store new player y position
	ply_mov_ed:
	# MOVE ENEMIES _________________________________________________________
	lw	$s0,	n_enms	# number of living enemies (next non-living idx)
	sub	$s0,	$s0,	1	# enemy idx offset for first stack frame
	mul	$s0,	$s0,	$s6	# multiply for ptr-diff offset of first
	add	$s0,	$sp,	$s0	# first enemy addr = array base + offset

	enm_mov:	# enemy movement loop (iterate over live enemies)
	blt	$s0,	$sp,	enm_mov_ed	# loop termination condition

	lw	$s1,	ENM_X($s0)	# load enemy's current x pos from struct
	sw	$s1,	ENM_X1($s0)	# load enemy previous x pos into old pos
	addi	$s1,	$s1,	-1	# decrement enemy x position (move left)
	sw	$s1,	ENM_X($s0)	# store the enemy's new x pos to struct

	addi	$s0,	$s0,	-ENM_DAT# move enemy index pointer up the stack
	b	enm_mov	# re-iterate until all enemies moved
	enm_mov_ed:	# end enemy movement
	# PROCESS COLLISION ____________________________________________________
	# load player info outside loop
	la	$s2,	player

	li	$s7,	DNE

	lw	$s3,	PLY_X($s2)
	lw	$s4,	PLY_Y($s2)
	
	lw	$s0,	n_enms	# number of living enemies (next non-living idx)
	sub	$s0,	$s0,	1	# enemy idx offset for first stack frame
	mul	$s0,	$s0,	$s6	# multiply for ptr-diff offset of first
	add	$s0,	$sp,	$s0	# first enemy addr = array base + offset

	cld_tst:	# enemy movement loop (iterate over live enemies)
	blt	$s0,	$sp,	cld_tst_ed	# loop termination condition
	bgez	$s7,	cld_tst_ed	# collided with something

	lw	$s1,	ENM_X($s0)	# load enemy's current x pos from struct
	lw	$s5,	ENM_Y($s0)	# load enemy's current y pos from struct
	sub	$s1,	$s1,	$s3	# get player-enemy x-offset
	sub	$s5,	$s5,	$s4	# get player-enemy y-offset
	mul	$s1,	$s1,	$s1	# get player-enemy x-offset
	mul	$s5,	$s5,	$s5	# get player-enemy y-offset
	add	$s1,	$s1,	$s5	# get squared player offset

	li	$s5,	ZK_RAD
	addi	$s5,	$s5,	PLY_RAD
	addi	$s5,	$s5,	1
	mul	$s5,	$s5,	$s5

	bge	$s1,	$s5,	no_clde	# player and enemy radii not overlapping

	# get y coord
	li	$v0,	RNG_RNG	# ranged RNG
	li	$a0,	0	# generator (0)
	li	$a1,	3	# max rng return (0 - SCR_Y) - ZK_DIM for render
				# pollution
	syscall
	move	$s7,	$a0

	la	$a0,	Dcolsn			#                          DEBUG
	jal	dbg_prt				#                          DEBUG

	no_clde:
	addi	$s0,	$s0,	-ENM_DAT# move enemy index pointer up the stack
	b	cld_tst	# re-iterate until all possible collisions checked
	cld_tst_ed:	# end collision check

	bgez	$s7,	did_cld
	dnt_cld:
	sw	$s7,	PLY_CLD($s2)
	b	collide_ed
	did_cld:
	lw	$s1,	PLY_CLD($s2)	# get player old collision information
	bgez	$s1,	was_cld	# had collided previously, continuation
	wnt_cld:	# was not previously collided
	sw	$s7,	PLY_CLD($s2)	# set player collision value to s7
	was_cld:	# was previously collided as well
	collide_ed:	# finish collision

	# SPAWN NEW ENEMIES ____________________________________________________
	# note: intentionally give player 1 tick's grace period with new enemies
	lw	$s0,	n_enms	# number of living enemies (next non-living idx)
	li	$s7,	MAX_ENM # load frequently user max number of enemies
	sub	$s0,	$s7,	$s0	# number of enemies left to be generated

	enm_gen:	# enemy generation loop
	blez	$s0,	enm_gen_end	# end enemy gen when max enemies spawned

	# la	$a0,	Dg_enm			#                          DEBUG
	# jal	dbg_prt				#                          DEBUG

	addi	$sp,	$sp,	-ENM_DAT# add space to the stack for a new enemy

	move	$a0,	$sp		# explicitly pass address to spawn enemy
	jal	spwn			# spawn new enemy into the given address

	addi	$s0,	$s0,	-1	# decrement total number left to respawn

	b	enm_gen	# re-evaluate loop condition
	enm_gen_end:	# enemy generation loop terminator

	sw	$s7,	n_enms	# update the number of living enemies to maximum

	# RENDER _______________________________________________________________
	# ENEMY
	lw	$s0,	n_enms	# number of living enemies (next non-living idx)
	sub	$s0,	$s0,	1	# enemy idx offset for first stack frame
	mul	$s0,	$s0,	$s6	# multiply for ptr-diff offset of first
	add	$s0,	$sp,	$s0	# first enemy addr = array base + offset

	la	$a0,	SCR_ADR	# load screen address as arg for following rndzk
	li	$a3,	SCR_X	# load scrn width as arg in following rndzk call

	enm_rnd:	# enemy render loop (iterate over live enemies)
	blt	$s0,	$sp,	enm_rnd_ed	# loop termination condition

	lw	$a1,	ENM_X($s0)		# load enemy's x for render func
	lw	$a2,	ENM_Y($s0)		# load enemy's y for render func
	jal	rndzk

	addi	$s0,	$s0,	-ENM_DAT# move enemy index pointer up the stack
	b	enm_rnd	# re-iterate until all enemies moved
	enm_rnd_ed:	# end enemy render

	# PLAYER
	la	$s0,	player	# load pointer-to-player for following functions

	lw	$a1,	PLY_X($s0)	# load player x position for render func
	lw	$a2,	PLY_Y($s0)	# load player y position for render func
	lw	$a3,	PLY_CLD($s0)	# load collision status for explosion
	jal	rndply

	b	GME_LP	# repeat the game loop

	li	$v0,	END	# terminate the program
	syscall

spwn:	# spawn a new enemy on the extreme right at a random height
	move	$t0,	$a0	# store enemy address in t0

	# get radius
	li	$t1,	ZK_RAD		#                                   TODO
	sw	$t1,	ENM_R($t0)	# store enemy radius

	# get x coord
	li	$v0,	RNG_RNG	# ranged RNG
	li	$a0,	0	# generator (0)
	li	$a1,	SPW_STG	# max rng return (0 - SPW_STG)
	syscall
	addi	$a0,	$a0,	SCR_X	# offset to far right of the screen
	add	$a0,	$a0,	$t1	# add enemy radius to offset to prevent
					# partial sprite overlap
	sw	$a0,	ENM_X($t0)	# store enemy x pos
	sw	$a0,	ENM_X1($t0)	# init enemy old x to start x

	# get y coord
	li	$v0,	RNG_RNG	# ranged RNG
	li	$a0,	0	# generator (0)
	li	$a1,	SCR_Y	# max rng return (0 - SCR_Y) - ZK_DIM for render
				# pollution
	syscall

	sw	$a0,	ENM_Y($t0)	# store enemy y pos (return value)

	jr	$ra			# return

rndzk:	# render an enemy high-z(aku)
	# calculate high-z(aku) position to framebuffer offset
	mul	$t0,	$a3,	$a2	# y * max x as row offset
	add	$t0,	$t0,	$a1	# row offset + row pos for offset index
	li	$t1,	WRD_LEN		# load WRD_LEN for next step's multiply
	mul	$t0,	$t0,	$t1	# mult by WRD_LEN for true ptr diff
	add	$t0,	$t0,	$a0	# add pointer difference to base for pos

	# load assets into registers to prevent having to re-fetch
	li	$t2,	C_ZK_EY
	li	$t3,	C_ZK_SC
	li	$t4,	C_ZK_PP
	li	$t5,	C_ZK_DK
	li	$t6,	C_ZK_LT
	li	$t7,	C_ZK_MT

	# check if the sprite is beyond or bisected by right-hand frame
	addi	$t1,	$a3,	-ZK_RAD		# add zaku radius offset to end
	addi	$t1,	$t1,	-1		# add less-than exclusive neg 1
	addi	$t1,	$t1,	-1		# add shadow space to right side
	bgt	$a1,	$t1,	rndzk_head	# either beyond or on right side

	rndzk_tail:	# render part or all of the back of the helmet
	li	$t1,	ZK_RAD	# radius: if x >= this, then lives inside frame
	bge	$a1,	$t1,	rndzk4
	# decrementally slice the helmet to further from the front as move back
	addi	$t1,	$t1,	-1
	beq	$a1,	$t1,	rndzk3
	addi	$t1,	$t1,	-1
	beq	$a1,	$t1,	rndzk2
	addi	$t1,	$t1,	-1
	beq	$a1,	$t1,	rndzk1
	addi	$t1,	$t1,	-1
	beq	$a1,	$t1,	rndzk0
	addi	$t1,	$t1,	-1
	beq	$a1,	$t1,	rndzkc

	jr	$ra	# no portion is visible; return without doing anything

	# TAIL
	# each rndzk<n> is a slice of the helmet sprite; offsets explained above
	rndzk4:
		# UNUSED
		sw	$t5,	-Yp1Xp2($t0)
		sw	$t2,	-Y_0Xp2($t0)
		sw	$t4,	Yp1Xm2($t0)
		sw	$t7,	Yp2Xm2($t0)
	rndzk3:
		sw	$t6,	-Yp2Xp1($t0)
		sw	$t5,	-Yp1Xp1($t0)
		sw	$t3,	-Y_0Xp1($t0)
		sw	$t4,	Yp1Xm1($t0)
		sw	$t5,	Yp2Xm1($t0)
	rndzk2:
		sw	$t6,	-Yp2X_0($t0)
		sw	$t5,	-Yp1X_0($t0)
		sw	$t4,	Y_0X_0($t0)
		sw	$t4,	Yp1X_0($t0)
		sw	$t6,	Yp2X_0($t0)
	rndzk1:
		sw	$t6,	-Yp2Xm1($t0)
		sw	$t6,	-Yp1Xm1($t0)
		sw	$t4,	Y_0Xp1($t0)
		sw	$t6,	Yp1Xp1($t0)
		sw	$t6,	Yp2Xp1($t0)
	rndzk0:
		sw	$zero,	-Yp2Xm2($t0)
		sw	$t6,	-Yp1Xm2($t0)
		sw	$t6,	Y_0Xp2($t0)
		sw	$t6,	Yp1Xp2($t0)
		sw	$zero,	Yp2Xp2($t0)
	rndzkc:	# clear column; remove trailing colour
		# UNUSED
		sw	$zero,	-Yp1Xm3($t0)
		sw	$zero,	Y_0Xp3($t0)
		sw	$zero,	Yp1Xp3($t0)
		# UNUSED

	jr	$ra	# return after rendering

	rndzk_head:	# render part of the front of the helmet
	li	$t1,	SCR_X
	addi	$t1,	$t1,	ZK_RAD
	bge	$a1,	$t1,	rndzk_x
	addi	$t1,	$t1,	-1
	beq	$a1,	$t1,	rndzk_4
	addi	$t1,	$t1,	-1
	beq	$a1,	$t1,	rndzk_3
	addi	$t1,	$t1,	-1
	beq	$a1,	$t1,	rndzk_2
	addi	$t1,	$t1,	-1
	beq	$a1,	$t1,	rndzk_1
	
	# HEAD
	# same as with the tail end, but these slices fall through back-to-front
	rndzk_0:
		sw	$zero,	-Yp2Xm2($t0)
		sw	$t6,	-Yp1Xm2($t0)
		sw	$t6,	Y_0Xp2($t0)
		sw	$t6,	Yp1Xp2($t0)
		sw	$zero,	Yp2Xp2($t0)
	rndzk_1:
		sw	$t6,	-Yp2Xm1($t0)
		sw	$t6,	-Yp1Xm1($t0)
		sw	$t4,	Y_0Xp1($t0)
		sw	$t6,	Yp1Xp1($t0)
		sw	$t6,	Yp2Xp1($t0)
	rndzk_2:
		sw	$t6,	-Yp2X_0($t0)
		sw	$t5,	-Yp1X_0($t0)
		sw	$t4,	Y_0X_0($t0)
		sw	$t4,	Yp1X_0($t0)
		sw	$t6,	Yp2X_0($t0)
	rndzk_3:
		sw	$t6,	-Yp2Xp1($t0)
		sw	$t5,	-Yp1Xp1($t0)
		sw	$t3,	-Y_0Xp1($t0)
		sw	$t4,	Yp1Xm1($t0)
		sw	$t5,	Yp2Xm1($t0)
	rndzk_4:
		# UNUSED
		sw	$t5,	-Yp1Xp2($t0)
		sw	$t2,	-Y_0Xp2($t0)
		sw	$t4,	Yp1Xm2($t0)
		sw	$t7,	Yp2Xm2($t0)
	rndzk_x:

	jr	$ra	# return after rendering (if not rndzk_x)

rndply:	# render the player's sprite
	# calculate player position to framebuffer offset
	li	$t0,	SCR_X
	mul	$t0,	$t0,	$a2	# y * max x as row offset
	add	$t0,	$t0,	$a1	# row offset + row pos for offset index
	li	$t1,	WRD_LEN		# load WRD_LEN for next step's multiply
	mul	$t0,	$t0,	$t1	# mult by WRD_LEN for true ptr diff
	add	$t0,	$t0,	$a0	# add pointer difference to base for pos

	# load assets into registers to prevent having to re-fetch
	li	$t2,	C_GD_EY
	li	$t3,	C_GD_CK
	li	$t4,	C_GD_CR
	li	$t5,	C_GD_HR
	li	$t6,	C_GD_AC
	li	$t7,	C_GD_NK
	li	$t8,	C_GD_DK
	li	$t9,	C_GD_LT

	# UNUSED
	sw	$t6,	-Yp1Xp2($t0)
	sw	$t8,	-Y_0Xp2($t0)
	sw	$t7,	Yp1Xm2($t0)
	# UNUSED

	sw	$t6,	-Yp2Xp1($t0)
	sw	$t8,	-Yp1Xp1($t0)
	sw	$t8,	-Y_0Xp1($t0)
	sw	$t7,	Yp1Xm1($t0)
	sw	$t7,	Yp2Xm1($t0)

	sw	$t4,	-Yp2X_0($t0)
	sw	$t8,	-Yp1X_0($t0)
	sw	$t3,	Y_0X_0($t0)
	sw	$t3,	Yp1X_0($t0)
	sw	$t9,	Yp2X_0($t0)

	sw	$t4,	-Yp2Xm1($t0)
	sw	$t8,	-Yp1Xm1($t0)
	sw	$t2,	Y_0Xp1($t0)
	sw	$t3,	Yp1Xp1($t0)
	sw	$t9,	Yp2Xp1($t0)

	sw	$t5,	-Yp3Xm2($t0)

	sw	$t5,	-Yp2Xm2($t0)
	sw	$t3,	-Yp1Xm2($t0)
	sw	$t2,	Y_0Xp2($t0)
	sw	$t9,	Yp1Xp2($t0)
	# UNUSED

	la	$t2,	player
	lw	$t3,	PLY_MOV($t2)

	beqz	$t3,	clrply_x

	beq	$t3,	KBD_W,	clrply_w
	beq	$t3,	KBD_A,	clrply_a
	beq	$t3,	KBD_S,	clrply_s
	beq	$t3,	KBD_D,	clrply_d

	clrply_w:
	sw	$zero,	Yp2Xm2($t0)
	sw	$zero,	Yp3Xm1($t0)
	sw	$zero,	Yp3X_0($t0)
	sw	$zero,	Yp3Xp1($t0)
	sw	$zero,	Yp2Xp2($t0)

	b	clrply_x

	clrply_a:
	sw	$zero,	-Yp3Xm3($t0)
	sw	$zero,	-Yp2Xm3($t0)
	sw	$zero,	-Yp1Xm3($t0)
	sw	$zero,	Y_0Xp3($t0)
	sw	$zero,	Yp1Xp3($t0)
	sw	$zero,	Yp2Xp2($t0)

	b	clrply_x

	clrply_s:
	sw	$zero,	-Yp2Xp2($t0)
	sw	$zero,	-Yp3Xp1($t0)
	sw	$zero,	-Yp3X_0($t0)
	sw	$zero,	-Yp3Xm1($t0)
	sw	$zero,	-Yp4Xm2($t0)

	b	clrply_x

	clrply_d:
	sw	$zero,	-Yp3Xm1($t0)
	sw	$zero,	-Yp2Xp2($t0)
	sw	$zero,	-Yp1Xp3($t0)
	sw	$zero,	-Y_0Xp3($t0)
	sw	$zero,	Yp1Xm3($t0)
	sw	$zero,	Yp2Xm2($t0)

	b	clrply_x

	clrply_x:

	bgez	$a3,	rndexpl

	jr	$ra	# return after rendering

	rndexpl:

	li	$t1,	C_EXP_1	# load primary explosion colour
	li	$t2,	C_EXP_2	# load secondary explosion colour

	beqz	$a3,	ml_expl	# explosion in middle-left if return valus is 0
	addi	$a3,	$a3,	-1	# prevent li with return value adjust
	beqz	$a3,	br_expl	# explosion in bottom-right if return value is 0

	tr_expl:

	# row-based
	# row 1
	sw	$t1,	-Yp2X_0($t0)
	sw	$t1,	-Yp2Xm1($t0)
	sw	$t2,	-Yp2Xm2($t0)
	# row 2
	sw	$t1,	-Yp1X_0($t0)
	sw	$t2,	-Yp1Xm1($t0)
	sw	$t1,	-Yp1Xm2($t0)
	# row 3
	sw	$t1,	-Y_0X_0($t0)
	sw	$t2,	Y_0Xp1($t0)
	sw	$t2,	Y_0Xp2($t0)

	b	ed_expl

	ml_expl:

	# row-based
	# row 1
	sw	$t1,	-Yp1Xp1($t0)
	# row 2
	sw	$t1,	-Y_0Xp2($t0)
	sw	$t2,	-Y_0Xp1($t0)
	sw	$t2,	Y_0X_0($t0)
	# row 3
	sw	$t2,	-Y_0Xp2($t0)

	b	ed_expl

	br_expl:

	# row-based
	# row 1
	sw	$t1,	Yp1X_0($t0)
	sw	$t2,	Yp1Xp1($t0)
	# row 2
	sw	$t1,	Yp2X_0($t0)
	sw	$t1,	Yp2Xp1($t0)

	ed_expl:

	jr	$ra	# return after rendering

clrxpl:	# render an explosion 

	jr	$ra	# return after rendering

dbg_prt:# print a provided debug message and return
	li	$v0,	PRT_VAR
	syscall
	jr	$ra

dbg_enm:# print an enemy's information and return
	move	$t0,	$a0	# store enemy address in t0

	li	$v0,	PRT_VAR
	la	$a0,	Denm_x
	syscall
	li	$v0,	PRT_REG
	lw	$a0,	0($t0)
	syscall

	li	$v0,	PRT_VAR
	la	$a0,	Denm_y
	syscall
	li	$v0,	PRT_REG
	lw	$a0,	4($t0)
	syscall

	li	$v0,	PRT_VAR	
	la	$a0,	Denm_r
	syscall
	li	$v0,	PRT_REG
	lw	$a0,	8($t0)
	syscall

	jr	$ra
