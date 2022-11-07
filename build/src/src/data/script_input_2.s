.module script_input_2

.include "vm.i"
.include "data/game_globals.i"
.include "macro.i"

.globl _fade_frames_per_step, ___bank_scene_title_screen, _scene_title_screen

.area _CODE_255

.SCRIPT_ARG_INDIRECT_0_VARIABLE = -7
.SCRIPT_ARG_INDIRECT_1_VARIABLE = -8
.SCRIPT_ARG_INDIRECT_2_VARIABLE = -9
.LOCAL_TMP0_MENU_RESULT = -4
.LOCAL_TMP1_HAS_LOADED = -4
.LOCAL_ACTOR = -4

___bank_script_input_2 = 255
.globl ___bank_script_input_2

_script_input_2::
        VM_RESERVE              4

        ; Text Menu
        VM_LOAD_TEXT            0
        .asciz "\001\001\003\003\002\002\001Help\n\002\001Save\n\002\001Home\n\002\001-Back"
        VM_OVERLAY_CLEAR        0, 0, 10, 6, .UI_COLOR_WHITE, ^/(.UI_AUTO_SCROLL | .UI_DRAW_FRAME)/
        VM_OVERLAY_MOVE_TO      10, 18, .OVERLAY_SPEED_INSTANT
        VM_OVERLAY_MOVE_TO      10, 12, .OVERLAY_IN_SPEED
        VM_DISPLAY_TEXT
        VM_OVERLAY_WAIT         .UI_MODAL, ^/(.UI_WAIT_WINDOW | .UI_WAIT_TEXT)/
        VM_CHOICE               .LOCAL_TMP0_MENU_RESULT, ^/(.UI_MENU_LAST_0 | .UI_MENU_CANCEL_B)/, 4
            .MENUITEM           1, 1, 1, 4, 0, 2
            .MENUITEM           1, 2, 1, 4, 1, 3
            .MENUITEM           1, 3, 1, 4, 2, 4
            .MENUITEM           1, 4, 1, 4, 3, 0
        VM_OVERLAY_MOVE_TO      10, 18, .OVERLAY_OUT_SPEED
        VM_OVERLAY_WAIT         .UI_MODAL, ^/(.UI_WAIT_WINDOW | .UI_WAIT_TEXT)/
        VM_OVERLAY_MOVE_TO      0, 18, .OVERLAY_SPEED_INSTANT
        VM_SET_INDIRECT         .SCRIPT_ARG_INDIRECT_2_VARIABLE, .LOCAL_TMP0_MENU_RESULT

        ; If Variable .EQ Value
        VM_PUSH_VALUE_IND       .SCRIPT_ARG_INDIRECT_2_VARIABLE
        VM_IF_CONST             .EQ, .ARG0, 1, 1$, 1
        VM_JUMP                 2$
1$:
        ; Text Dialogue
        VM_LOAD_TEXT            0
        .asciz "Ollie     : B\nkickflip  : B+UP\nOllie 180 : B+DOWN"
        VM_OVERLAY_CLEAR        0, 0, 20, 5, .UI_COLOR_WHITE, ^/(.UI_AUTO_SCROLL | .UI_DRAW_FRAME)/
        VM_OVERLAY_MOVE_TO      0, 13, .OVERLAY_IN_SPEED
        VM_DISPLAY_TEXT
        VM_OVERLAY_WAIT         .UI_MODAL, ^/(.UI_WAIT_WINDOW | .UI_WAIT_TEXT | .UI_WAIT_BTN_A)/
        VM_LOAD_TEXT            0
        .asciz "Grind     :A(HOLD)"
        VM_OVERLAY_CLEAR        0, 0, 20, 5, .UI_COLOR_WHITE, ^/(.UI_AUTO_SCROLL | .UI_DRAW_FRAME)/
        VM_DISPLAY_TEXT
        VM_OVERLAY_WAIT         .UI_MODAL, ^/(.UI_WAIT_WINDOW | .UI_WAIT_TEXT | .UI_WAIT_BTN_A)/
        VM_OVERLAY_MOVE_TO      0, 18, .OVERLAY_OUT_SPEED
        VM_OVERLAY_WAIT         .UI_MODAL, ^/(.UI_WAIT_WINDOW | .UI_WAIT_TEXT)/

2$:

        ; If Variable .EQ Value
        VM_PUSH_VALUE_IND       .SCRIPT_ARG_INDIRECT_2_VARIABLE
        VM_IF_CONST             .EQ, .ARG0, 2, 3$, 1
        VM_JUMP                 4$
3$:
        ; Save Data to Slot 0
        VM_RAISE                EXCEPTION_SAVE, 1
            .SAVE_SLOT 0
        VM_POLL_LOADED          .LOCAL_TMP1_HAS_LOADED
        VM_IF_CONST             .EQ, .LOCAL_TMP1_HAS_LOADED, 1, 5$, 0

5$:

4$:

        ; If Variable .EQ Value
        VM_PUSH_VALUE_IND       .SCRIPT_ARG_INDIRECT_2_VARIABLE
        VM_IF_CONST             .EQ, .ARG0, 3, 6$, 1
        VM_JUMP                 7$
6$:
        ; Load Scene
        VM_SET_CONST_INT8       _fade_frames_per_step, 3
        VM_FADE_OUT             1
        VM_SET_CONST            .LOCAL_ACTOR, 0
        VM_SET_CONST            ^/(.LOCAL_ACTOR + 1)/, 0
        VM_SET_CONST            ^/(.LOCAL_ACTOR + 2)/, 0
        VM_ACTOR_SET_POS        .LOCAL_ACTOR
        VM_ACTOR_SET_DIR        .LOCAL_ACTOR, .DIR_DOWN
        VM_RAISE                EXCEPTION_CHANGE_SCENE, 3
            IMPORT_FAR_PTR_DATA _scene_title_screen

7$:

        ; Stop Script
        VM_STOP
