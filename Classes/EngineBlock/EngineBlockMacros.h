/* */

/*  EngineBlockMacros.h
 *  EngineBlock
 *
 *  Created by Adam Duke on 1/14/11.
 *  Copyright 2011 None. All rights reserved.
 *
 */

/* borrowed from https://github.com/facebook/three20 */
#define TT_RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }