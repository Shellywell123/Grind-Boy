.include "vm.i"
.include "macro.i"
.include "data/game_globals.i"

; define constants in rom bank 0
.area _CODE

_start_scene_x:: 
        .dw 0
_start_scene_y:: 
        .dw 6272 
_start_scene_dir:: 
        .db .DIR_RIGHT
_start_scene::
        IMPORT_FAR_PTR_DATA _scene_logo
_start_player_move_speed:: 
        .db 64
_start_player_anim_tick:: 
        .db 7
_ui_fonts:: 
        IMPORT_FAR_PTR_DATA _font_gbs_variable_width


; define engine init VM routine which will be packed into some bank
.area _CODE_255

___bank_script_engine_init = 255
.globl ___bank_script_engine_init

.globl _plat_min_vel
.globl _plat_walk_vel
.globl _plat_run_vel
.globl _plat_climb_vel
.globl _plat_walk_acc
.globl _plat_run_acc
.globl _plat_dec
.globl _plat_jump_vel
.globl _plat_grav
.globl _plat_hold_grav
.globl _plat_max_fall_vel
.globl _shooter_scroll_speed
.globl _topdown_grid
.globl _fade_style

_script_engine_init::
        VM_SET_CONST_INT16      _plat_min_vel, 1311
        VM_SET_CONST_INT16      _plat_walk_vel, 13831
        VM_SET_CONST_INT16      _plat_run_vel, 15000
        VM_SET_CONST_INT16      _plat_climb_vel, 4000
        VM_SET_CONST_INT16      _plat_walk_acc, 750
        VM_SET_CONST_INT16      _plat_run_acc, 750
        VM_SET_CONST_INT16      _plat_dec, 75
        VM_SET_CONST_INT16      _plat_jump_vel, 21703
        VM_SET_CONST_INT16      _plat_grav, 1792
        VM_SET_CONST_INT16      _plat_hold_grav, 1739
        VM_SET_CONST_INT16      _plat_max_fall_vel, 20000
        VM_SET_CONST_INT16      _shooter_scroll_speed, 16
        VM_SET_CONST_INT16      _topdown_grid, 8
        VM_SET_CONST_INT16      _fade_style, 1



        ; return from init routine
        VM_RET_FAR
