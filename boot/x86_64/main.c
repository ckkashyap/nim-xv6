#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"

static void startothers(void);
static void mpmain(void)  __attribute__((noreturn));
extern pde_t *kpgdir;
extern char end[]; // first address after kernel loaded from ELF file

// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.

void nimMain();
int
main(void)
{
  int i;
  char *screen=(char*)0xb8000;
  char ch = 'A';
  char cl[] = {0x1f, 0x0e, 0x4f};
  int ci=0;
  while(1) {
	  ch='A';
	  for (i=0;i<4000;i+=2){
		  screen[i]=ch;
		  ch++;
		  if(ch>'Z')ch='A';
		  screen[i+1]=cl[ci];
	  }
	  ci++;
	  if(ci==3)ci=0;
	  nimMain();
  }
}

// Other CPUs jump here from entryother.S.
void
mpenter(void)
{
}

// Common CPU setup code.
static void
mpmain(void)
{
}

pde_t entrypgdir[];  // For entry.S
void entry32mp(void);

// Start the non-boot (AP) processors.
static void
startothers(void)
{
}

#ifndef X64
// Boot page table used in entry.S and entryother.S.
// Page directories (and page tables), must start on a page boundary,
// hence the "__aligned__" attribute.  
// Use PTE_PS in page directory entry to enable 4Mbyte pages.
__attribute__((__aligned__(PGSIZE)))
pde_t entrypgdir[NPDENTRIES] = {
  // Map VA's [0, 4MB) to PA's [0, 4MB)
  [0] = (0) | PTE_P | PTE_W | PTE_PS,
  // Map VA's [KERNBASE, KERNBASE+4MB) to PA's [0, 4MB)
  [KERNBASE>>PDXSHIFT] = (0) | PTE_P | PTE_W | PTE_PS,
};
#endif

//PAGEBREAK!
// Blank page.

