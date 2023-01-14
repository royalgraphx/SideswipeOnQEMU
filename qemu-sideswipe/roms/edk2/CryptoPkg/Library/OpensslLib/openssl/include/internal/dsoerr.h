/*
 * Generated by util/mkerr.pl DO NOT EDIT
 * Copyright 1995-2018 The OpenSSL Project Authors. All Rights Reserved.
 *
 * Licensed under the OpenSSL license (the "License").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */

#ifndef HEADER_DSOERR_H
# define HEADER_DSOERR_H

# include <openssl/opensslconf.h>

# ifndef OPENSSL_NO_DSO

#  ifdef  __cplusplus
extern "C"
#  endif
int ERR_load_DSO_strings(void);

/*
 * DSO function codes.
 */
#  define DSO_F_DLFCN_BIND_FUNC                            100
#  define DSO_F_DLFCN_LOAD                                 102
#  define DSO_F_DLFCN_MERGER                               130
#  define DSO_F_DLFCN_NAME_CONVERTER                       123
#  define DSO_F_DLFCN_UNLOAD                               103
#  define DSO_F_DL_BIND_FUNC                               104
#  define DSO_F_DL_LOAD                                    106
#  define DSO_F_DL_MERGER                                  131
#  define DSO_F_DL_NAME_CONVERTER                          124
#  define DSO_F_DL_UNLOAD                                  107
#  define DSO_F_DSO_BIND_FUNC                              108
#  define DSO_F_DSO_CONVERT_FILENAME                       126
#  define DSO_F_DSO_CTRL                                   110
#  define DSO_F_DSO_FREE                                   111
#  define DSO_F_DSO_GET_FILENAME                           127
#  define DSO_F_DSO_GLOBAL_LOOKUP                          139
#  define DSO_F_DSO_LOAD                                   112
#  define DSO_F_DSO_MERGE                                  132
#  define DSO_F_DSO_NEW_METHOD                             113
#  define DSO_F_DSO_PATHBYADDR                             105
#  define DSO_F_DSO_SET_FILENAME                           129
#  define DSO_F_DSO_UP_REF                                 114
#  define DSO_F_VMS_BIND_SYM                               115
#  define DSO_F_VMS_LOAD                                   116
#  define DSO_F_VMS_MERGER                                 133
#  define DSO_F_VMS_UNLOAD                                 117
#  define DSO_F_WIN32_BIND_FUNC                            101
#  define DSO_F_WIN32_GLOBALLOOKUP                         142
#  define DSO_F_WIN32_JOINER                               135
#  define DSO_F_WIN32_LOAD                                 120
#  define DSO_F_WIN32_MERGER                               134
#  define DSO_F_WIN32_NAME_CONVERTER                       125
#  define DSO_F_WIN32_PATHBYADDR                           109
#  define DSO_F_WIN32_SPLITTER                             136
#  define DSO_F_WIN32_UNLOAD                               121

/*
 * DSO reason codes.
 */
#  define DSO_R_CTRL_FAILED                                100
#  define DSO_R_DSO_ALREADY_LOADED                         110
#  define DSO_R_EMPTY_FILE_STRUCTURE                       113
#  define DSO_R_FAILURE                                    114
#  define DSO_R_FILENAME_TOO_BIG                           101
#  define DSO_R_FINISH_FAILED                              102
#  define DSO_R_INCORRECT_FILE_SYNTAX                      115
#  define DSO_R_LOAD_FAILED                                103
#  define DSO_R_NAME_TRANSLATION_FAILED                    109
#  define DSO_R_NO_FILENAME                                111
#  define DSO_R_NULL_HANDLE                                104
#  define DSO_R_SET_FILENAME_FAILED                        112
#  define DSO_R_STACK_ERROR                                105
#  define DSO_R_SYM_FAILURE                                106
#  define DSO_R_UNLOAD_FAILED                              107
#  define DSO_R_UNSUPPORTED                                108

# endif
#endif
