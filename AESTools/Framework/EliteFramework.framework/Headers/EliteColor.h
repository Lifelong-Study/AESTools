//
//  EliteCategories.h
//  BLEDrawingPad
//
//  Created by Lifelong-Study on 2015/4/21.
//  Copyright (c) 2015年 PaoYo Ding. All rights reserved.
//

#import <UIKit/UIKit.h>

//
#define GET_MACRO(_1, _2, NAME, ...) NAME
#define EliteColor(...) GET_MACRO(__VA_ARGS__, __EliteColor2, __EliteColor1)(__VA_ARGS__)

#define __EliteColor1(a)       [UIColor colorWithHex:a]
#define __EliteColor2(a, b)    [UIColor colorWithHex:a alpha:b]


@interface UIColor (EliteColorCategory)

//!
+ (UIColor *)colorWithHex:(unsigned int)hex;

//!
+ (UIColor *)colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;

//!
+ (UIColor *)colorWithImage:(UIImage *)image x:(int)x y:(int)y;

//!
+ (NSInteger)getRedColorWithHex:(unsigned int)hex;

//!
+ (NSInteger)getGreenColorWithHex:(unsigned int)hex;

//!
+ (NSInteger)getBlueColorWithHex:(unsigned int)hex;

//!
- (UIColor *)getContrastingColor;



@end

//
#define TRANSPARENT_COLOR                   EliteColor(0x000000, 0.0)   // 透明
#define BLACK_COLOR                         0x000000    // 黑色
#define DIMGRAY_COLOR                       0x696969    // 昏灰
#define GRAY_COLOR                          0x808080    // 灰色
#define DARK_GRAY_COLOR                     0xA9A9A9    // 暗灰
#define SILVER_COLOR                        0xC0C0C0    // 銀色
#define LIGHT_GRAY_COLOR                    0xD3D3D3    // 亮灰色
#define GAINSBORO_COLOR                     0xDCDCDC    // 庚斯博羅灰
#define WHITE_SMOKE_COLOR                   0xF5F5F5    // 白煙色
#define WHITE_COLOR                         0xFFFFFF    // 白色
#define SNOW_COLOR                          0xFFFAFA    // 雪色
#define IRON_GRAY_COLOR                     0x625B57    // 鐵灰色
#define SAND_BEIGE_COLOR                    0xE6C3C3    // 沙棕
#define ROSY_BROWN_COLOR                    0xBC8F8F    // 玫瑰褐
#define LIGHT_CORAL_COLOR                   0xF08080    // 亮珊瑚色
#define INDIAN_RED_COLOR                    0xCD5C5C    // 印度紅
#define BROWN_COLOR                         0xA52A2A    // 褐色
#define FIRE_BRICK_COLOR                    0xB22222    // 耐火磚紅
#define MAROON_COLOR                        0x800000    // 栗色
#define DARK_RED_COLOR                      0x8B0000    // 暗紅
#define STRONG_RED_COLOR                    0xE60000    // 鮮紅
#define RED_COLOR                           0xFF0000    // 紅色
#define PERSIMMON_COLOR                     0xFF4D40    // 柿子橙
#define MISTY_ROSE_COLOR                    0xFFE4E1    // 霧玫瑰色
#define SALMON_COLOR                        0xFA8072    // 鮭紅
#define SCARLET_COLOR                       0xFF2400    // 腥紅
#define TOMATO_COLOR                        0xFF6347    // 蕃茄紅
#define DARK_SALMON_COLOR                   0xE9967A    // 暗鮭紅
#define CORAL_COLOR                         0xFF7F50    // 珊瑚紅
#define ORANGE_RED_COLOR                    0xFF4500    // 橙紅
#define LIGHT_SALMON_COLOR                  0xFFA07A    // 亮鮭紅
#define VERMILION_COLOR                     0xFF4D00    // 朱紅
#define SIENNA_COLOR                        0xA0522D    // 赭黃
#define TROPICAL_ORANGE_COLOR               0xFF8033    // 熱帶橙
#define CAMEL_COLOR                         0xA16B47    // 駝色
#define APRICOT_COLOR                       0xE69966    // 杏黃
#define COCONUT_BROWN_COLOR                 0x4D1F00    // 椰褐
#define SEASHELL_COLOR                      0xFFF5EE    // 海貝色
#define SADDLE_BROWN_COLOR                  0x8B4513    // 鞍褐
#define CHOCOLATE_COLOR                     0xD2691E    // 巧克力色
#define BURNT_ORANGE_COLOR                  0xCC5500    // 燃橙
#define SUN_ORANGE_COLOR                    0xFF7300    // 陽橙
#define PEACH_PUFF_COLOR                    0xFFDAB9    // 粉撲桃色
#define SAND_BROWN_COLOR                    0xF4A460    // 沙褐
#define BRONZE_COLOR                        0xB87333    // 古銅色
#define LINEN_COLOR                         0xFAF0E6    // 亞麻色
#define HONEY_ORANGE_COLOR                  0xFFB366    // 蜜橙
#define PERU_COLOR                          0xCD853F    // 秘魯色
#define SEPIA_COLOR                         0x704214    // 烏賊墨色
#define OCHER_COLOR                         0xCC7722    // 赭色
#define BISQUE_COLOR                        0xFFE4C4    // 陶坯黃
#define TANGERINE_COLOR                     0xF28500    // 橘色
#define DARK_ORANGE_COLOR                   0xFF8C00    // 暗橙
#define ANTIQUE_WHITE_COLOR                 0xFAEBD7    // 古董白
#define TAN_COLOR                           0xD2B48C    // 日曬色
#define BURLY_WOOD_COLOR                    0xDEB887    // 硬木色
#define BLANCHED_ALMOND_COLOR               0xFFEBCD    // 杏仁白
#define NAVAJO_WHITE_COLOR                  0xFFDEAD    // 那瓦霍白
#define MARIGOLD_COLOR                      0xFF9900    // 萬壽菊黃
#define PAPAYA_WHIP_COLOR                   0xFFEFD5    // 蕃木瓜色
#define PALE_OCRE_COLOR                     0xCCB38C    // 灰土色
#define KHAKI_COLOR                         0x996B1F    // 卡其色
#define MOCCASIN_COLOR                      0xFFE4B5    // 鹿皮鞋色
#define OLD_LACE_COLOR                      0xFDF5E6    // 舊蕾絲色
#define WHEAT_COLOR                         0xF5DEB3    // 小麥色
#define PEACH_COLOR                         0xFFE5B4    // 桃色
#define ORANGE_COLOR                        0xFFA500    // 橙色
#define FLORAL_WHITE_COLOR                  0xFFFAF0    // 花卉白
#define GOLDENROD_COLOR                     0xDAA520    // 金菊色
#define DARK_GOLDENROD_COLOR                0xB8860B    // 暗金菊色
#define COFFEE_COLOR                        0x4D3900    // 咖啡色
#define JASMINE_COLOR                       0xE6C35C    // 茉莉黃
#define AMBER_COLOR                         0xFFBF00    // 琥珀色
#define CORNSILK_COLOR                      0xFFF8DC    // 玉米絲色
#define CHROME_YELLOW_COLOR                 0xE6B800    // 鉻黃
#define GOLDEN_COLOR                        0xFFD700    // 金色
#define LEMON_CHIFFON_COLOR                 0xFFFACD    // 檸檬綢色
#define LIGHT_KHAKI_COLOR                   0xF0E68C    // 亮卡其色
#define PALE_GOLDENROD_COLOR                0xEEE8AA    // 灰金菊色
#define DARK_KHAKI_COLOR                    0xBDB76B    // 暗卡其色
#define MIMOSA_COLOR                        0xE6D933    // 含羞草黃
#define CREAM_COLOR                         0xFFFDD0    // 奶油色
#define IVORY_COLOR                         0xFFFFF0    // 象牙色
#define BEIGE_COLOR                         0xF5F5DC    // 米黃色
#define LIGHT_YELLOW_COLOR                  0xFFFFE0    // 亮黃
#define LIGHT_GOLDENROD_YELLOW_COLOR        0xFAFAD2    // 亮金菊黃
#define CHAMPAGNE_YELLOW_COLOR              0xFFFF99    // 香檳黃
#define MUSTARD_COLOR                       0xCCCC4D    // 芥末黃
#define MOON_YELLOW_COLOR                   0xFFFF4D    // 月黃
#define OLIVE_COLOR                         0x808000    // 橄欖色
#define CANARY_YELLOW_COLOR                 0xFFFF00    // 鮮黃
#define YELLOW_COLOR                        0xFFFF00    // 黃色
#define MOSS_GREEN_COLOR                    0x697723    // 苔蘚綠
#define LIGHT_LIME_COLOR                    0xCCFF00    // 亮檸檬綠
#define OLIVE_DRAB_COLOR                    0x6B8E23    // 橄欖軍服綠
#define YELLOW_GREEN_COLOR                  0x9ACD32    // 黃綠
#define DARK_OLIVE_GREEN_COLOR              0x556B2F    // 暗橄欖綠
#define APPLE_GREEN_COLOR                   0x8CE600    // 蘋果綠
#define GREEN_YELLOW_COLOR                  0xADFF2F    // 綠黃
#define GRASS_GREEN_COLOR                   0x99E64D    // 草綠
#define LAWN_GREEN_COLOR                    0x7CFC00    // 草坪綠
#define CHARTREUSE_COLOR                    0x7FFF00    // 查特酒綠
#define FOLIAGE_GREEN_COLOR                 0x73B839    // 葉綠
#define FRESH_LEAVES_COLOR                  0x99FF4D    // 嫩綠
#define BRIGHT_GREEN_COLOR                  0x66FF00    // 明綠
#define COBALT_GREEN_COLOR                  0x66FF59    // 鈷綠
#define HONEYDEW_COLOR                      0xF0FFF0    // 蜜瓜綠
#define DARK_SEA_GREEN_COLOR                0x8FBC8F    // 暗海綠
#define LIGHT_GREEN_COLOR                   0x90EE90    // 亮綠
#define PALE_GREEN_COLOR                    0x98FB98    // 灰綠
#define IVY_GREEN_COLOR                     0x36BF36    // 常春藤綠
#define FOREST_GREEN_COLOR                  0x228B22    // 森林綠
#define LIME_GREEN_COLOR                    0x32CD32    // 檸檬綠
#define DARK_GREEN_COLOR                    0x006400    // 暗綠
#define GREEN_COLOR                         0x008000    // 綠色
#define LIME_COLOR                          0x00FF00    // 鮮綠色
#define MALACHITE_COLOR                     0x22C32E    // 孔雀石綠
#define MINT_COLOR                          0x16982B    // 薄荷綠
#define CELADON_GREEN_COLOR                 0x73E68C    // 青瓷綠
#define EMERALD_COLOR                       0x50C878    // 碧綠
#define TURQUOISE_GREEN_COLOR               0x4DE680    // 綠松石綠
#define VIRIDIAN_COLOR                      0x127436    // 鉻綠
#define HORIZON_BLUE_COLOR                  0xA6FFCC    // 蒼色
#define SEA_GREEN_COLOR                     0x2E8B57    // 海綠
#define MEDIUM_SEA_GREEN_COLOR              0x3CB371    // 中海綠
#define MINT_CREAM_COLOR                    0xF5FFFA    // 薄荷奶油色
#define SPRING_GREEN_COLOR                  0x00FF80    // 春綠
#define PEACOCK_GREEN_COLOR                 0x00A15C    // 孔雀綠
#define MEDIUM_SPRING_GREEN_COLOR           0x00FA9A    // 中春綠色
#define MEDIUM_AQUAMARINE_COLOR             0x66CDAA    // 中碧藍色
#define AQUAMARINE_COLOR                    0x7FFFD4    // 碧藍色
#define CYAN_BLUE_COLOR                     0x0DBF8C    // 青藍
#define AQUA_BLUE_COLOR                     0x66FFE6    // 水藍
#define TURQUOISE_BLUE_COLOR                0x33E6CC    // 綠松石藍
#define TURQUOISE_COLOR                     0x30D5C8    // 綠松石色
#define LIGHT_SEA_GREEN_COLOR               0x20B2AA    // 亮海綠
#define MEDIUM_TURQUOISE_COLOR              0x48D1CC    // 中綠松石色
#define LIGHT_CYAN_COLOR                    0xE0FFFF    // 亮青
#define BABY_BLUE_COLOR                     0xE0FFFF    // 淺藍
#define PALE_TURQUOISE_COLOR                0xAFEEEE    // 灰綠松石色
#define DARK_SLATE_GRAY_COLOR               0x2F4F4F    // 暗岩灰
#define TEAL_COLOR                          0x008080    // 鳧綠
#define DARK_CYAN_COLOR                     0x008B8B    // 暗青
#define CYAN_COLOR                          0x00FFFF    // 青色
#define AQUA_COLOR                          0xAFDFE4    // 水色
#define DARK_TURQUOISE_COLOR                0x00CED1    // 暗綠松石色
#define CADET_BLUE_COLOR                    0x5F9EA0    // 軍服藍
#define PEACOCK_BLUE_COLOR                  0x00808C    // 孔雀藍
#define POWDER_BLUE_COLOR                   0xB0E0E6    // 嬰兒粉藍
#define STRONG_BLUE_COLOR                   0x006374    // 濃藍
#define LIGHT_BLUE_COLOR                    0xADD8E6    // 亮藍
#define PALE_BLUE_COLOR                     0x7AB8CC    // 灰藍
#define SAXE_BLUE_COLOR                     0x4798B3    // 薩克斯藍
#define DEEP_SKY_BLUE_COLOR                 0x00BFFF    // 深天藍
#define SKY_BLUE_COLOR                      0x87CEEB    // 天藍
#define LIGHT_SKY_BLUE_COLOR                0x87CEFA    // 亮天藍
#define MARINE_BLUE_COLOR                   0x00477D    // 水手藍
#define PRUSSIAN_BLUE_COLOR                 0x003153    // 普魯士藍
#define STEEL_BLUE_COLOR                    0x4682B4    // 鋼青色
#define ALICE_BLUE_COLOR                    0xF0F8FF    // 愛麗絲藍
#define SLATE_GRAY_COLOR                    0x708090    // 岩灰
#define LIGHT_SLATE_GRAY_COLOR              0x778899    // 亮岩灰
#define DODGER_BLUE_COLOR                   0x1E90FF    // 道奇藍
#define MINERAL_BLUE_COLOR                  0x004D99    // 礦藍
#define AZURE_COLOR                         0x007FFF    // 湛藍
#define WEDGWOOD_BLUE_COLOR                 0x5686BF    // 韋奇伍德瓷藍
#define LIGHT_STEEL_BLUE_COLOR              0xB0C4DE    // 亮鋼藍
#define COBALT_BLUE_COLOR                   0x0047AB    // 鈷藍
#define PALE_DENIM_COLOR                    0x5E86C1    // 灰丁寧藍
#define CORNFLOWER_BLUE_COLOR               0x6495ED    // 矢車菊藍
#define SALVIA_BLUE_COLOR                   0x4D80E6    // 鼠尾草藍
#define DARK_POWDER_BLUE_COLOR              0x003399    // 暗嬰兒粉藍
#define SAPPHIRE_COLOR                      0x082567    // 藍寶石色
#define INTERNATIONAL_KLEIN_BLUE_COLOR      0x002FA7    // 國際奇連藍
#define CERULEAN_BLUE_COLOR                 0x2A52BE    // 蔚藍
#define ROYAL_BLUE_COLOR                    0x4169E1    // 品藍
#define DARK_MINERAL_BLUE_COLOR             0x24367D    // 暗礦藍
#define ULTRAMARINE_COLOR                   0x0033FF    // 極濃海藍
#define LAPIS_LAZULI_COLOR                  0x0D33FF    // 天青石藍
#define GHOST_WHITE_COLOR                   0xF8F8FF    // 幽靈白
#define LAVENDER_COLOR                      0xE6E6FA    // 薰衣草紫
#define PERIWINKLE_COLOR                    0xCCCCFF    // 長春花色
#define MIDNIGHT_BLUE_COLOR                 0x191970    // 午夜藍
#define NAVY_BLUE_COLOR                     0x000080    // 藏青
#define DARK_BLUE_COLOR                     0x00008B    // 暗藍
#define MEDIUM_BLUE_COLOR                   0x0000CD    // 中藍
#define BLUE_COLOR                          0x0000FF    // 藍色
#define WISTERIA_COLOR                      0x5C50E6    // 紫藤色
#define DARK_SLATE_BLUE_COLOR               0x483D8B    // 暗岩藍
#define SLATE_BLUE_COLOR                    0x6A5ACD    // 岩藍
#define MEDIUM_SLATE_BLUE_COLOR             0x7B68EE    // 中岩藍
#define MAUVE_COLOR                         0x6640FF    // 木槿紫
#define LILAC_COLOR                         0xB399FF    // 紫丁香色
#define MEDIUM_PURPLE_COLOR                 0x9370DB    // 中紫紅
#define AMETHYST_COLOR                      0x6633CC    // 紫水晶色
#define GRAYISH_PURPLE_COLOR                0x8674A1    // 淺灰紫紅
#define HELIOTROPE_COLOR                    0x5000B8    // 纈草紫
#define MINERAL_VIOLET_COLOR                0xB8A1CF    // 礦紫
#define BLUE_VIOLET_COLOR                   0x8A2BE2    // 藍紫
#define VIOLET_COLOR                        0x8B00FF    // 紫羅蘭色
#define INDIGO_COLOR                        0x4B0080    // 靛色
#define DARK_ORCHID_COLOR                   0x9932CC    // 暗蘭紫
#define DARK_VIOLET_COLOR                   0x9400D3    // 暗紫
#define PANSY_COLOR                         0x7400A1    // 三色堇紫
#define MALLOW_COLOR                        0xD94DFF    // 錦葵紫
#define OPERA_MAUVE_COLOR                   0xE680FF    // 優品紫紅
#define MEDIUM_ORCHID_COLOR                 0xBA55D3    // 中蘭紫
#define PAIL_LILAC_COLOR                    0xE6CFE6    // 淡紫丁香色
#define THISTLE_COLOR                       0xD8BFD8    // 薊紫
#define CLEMATIS_COLOR                      0xCCA3CC    // 鐵線蓮紫
#define PLUM_COLOR                          0xDDA0DD    // 梅紅色
#define LIGHT_VIOLET_COLOR                  0xEE82EE    // 亮紫
#define PURPLE_COLOR                        0x800080    // 紫色
#define DARK_MAGENTA_COLOR                  0x8B008B    // 暗洋紅
#define MAGENTA_COLOR                       0xFF00FF    // 洋紅
#define FUCHSIA_COLOR                       0xF400A1    // 品紅
#define ORCHID_COLOR                        0xDA70D6    // 蘭紫
#define PEARL_PINK_COLOR                    0xFFB3E6    // 淺珍珠紅
#define OLD_ROSE_COLOR                      0xB85798    // 陳玫紅
#define ROSE_PINK_COLOR                     0xFF66CC    // 淺玫瑰紅
#define MEDIUM_VIOLET_RED_COLOR             0xC71585    // 中青紫紅
#define MAGENTA_ROSE_COLOR                  0xFF0DA6    // 洋玫瑰紅
#define ROSE_COLOR                          0xFF007F    // 玫瑰紅
#define RUBY_COLOR                          0xCC0080    // 紅寶石色
#define CAMELLIA_COLOR                      0xE63995    // 山茶紅
#define DEEP_PINK_COLOR                     0xFF1493    // 深粉紅
#define FLAMINGO_COLOR                      0xE68AB8    // 火鶴紅
#define CORAL_PINK_COLOR                    0xFF80BF    // 淺珊瑚紅
#define HOT_PINK_COLOR                      0xFF69B4    // 暖粉紅
#define BURGUNDY_COLOR                      0x470024    // 勃艮第酒紅
#define SPINEL_RED_COLOR                    0xFF73B3    // 尖晶石紅
#define CARMINE_COLOR                       0xE6005C    // 胭脂紅
#define BABY_PINK_COLOR                     0xFFD9E6    // 淺粉紅
#define CARDINAL_RED_COLOR                  0x990036    // 樞機紅
#define LAVENDER_BLUSH_COLOR                0xFFF0F5    // 薰衣草紫紅
#define PALE_VIOLET_RED_COLOR               0xDB7093    // 灰紫紅
#define CERISE_COLOR                        0xDE3163    // 櫻桃紅
#define SALMON_PINK_COLOR                   0xFF8099    // 淺鮭紅
#define CRIMSON_COLOR                       0xDC143C    // 緋紅
#define PINK_COLOR                          0xFFC0CB    // 粉紅
#define LIGHT_PINK_COLOR                    0xFFB6C1    // 亮粉紅
#define SHELL_PINK_COLOR                    0xFFB3BF    // 殼黃紅
#define ALIZARIN_CRIMSON_COLOR              0xE32636    // 茜紅
