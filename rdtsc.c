/* 
 rdtsc - Reads and outputs the RDTSC instruction contents.
 Copyright (C) 2019  Robert V. <modrobert@gmail.com>

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include <stdint.h>
#include <stdio.h>
#include <inttypes.h>

static inline uint64_t rdtsc()
{
 uint32_t low, high;
 asm volatile ("rdtsc" : "=a" (low), "=d" (high));
 return (((uint64_t)high << 32) | low);
}

int main(void)
{

 uint64_t x;

 x = rdtsc();
 
 printf("%" PRIu64 "\n", x);

}

/* vim:ts=1:sw=1:ft=c:et:ai:
*/
