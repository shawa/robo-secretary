# -*- coding: utf-8 -*-
from __future__ import print_function
from random import choice
from subprocess import check_output

ur_name = check_output('whoami').decode('utf-8').strip()

fillers = (
    ("Hey", "Hi", "Hello", "Hej", "Oye", "Dia Dhaiobh", "Evening", "Morning") ,
    ("there", "all", "folks", "everyone", "alla"),
    ("I put the minutes in this email here",
     "Today's minutes", "Minutes from today", "Minutes from today's meeting",
     "Today's meeting minutes", "Minutes from earlier"),
    ("below", "attached", "here"),
    ("for your enjoyment", "for the laugh", "for your delight",
     "for your amusement"),
    ("Kind Regards", "Extremely Kind Regards", "Best Regards",
     "Worst Regards", "Warmest Regards", "Coldest Regards",
     "Temperate Regards", "Modern Regards", "Condolences",
     "Sinfully Yours", "Regretfully Yours", "Spookiest Regards",
     "Worst Wishes", "Worst", "Your obedient servant", "Disgracefully Yours",
     "Rebelliously Yours", "Insincerely", "Sincere Apologies"),
)

print('{} {}\n\n{} {} {}\n\n{},\n{}, Secretary, DU Netsoc'
      .format(*([choice(words) for words in fillers] + [ur_name])))
