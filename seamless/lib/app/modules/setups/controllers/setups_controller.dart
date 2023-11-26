import 'package:get/get.dart';

class SetupsController extends GetxController {
  //TODO: Implement SetupsController

  List speechSource = [
    { 'value': 'cmn', 'label': '普通话(中文)' },
    { 'value': 'jpn', 'label': '日本語' },
    { 'value': 'eng', 'label': '英语' },
    { 'value': 'afr', 'label': '南非荷兰语' },
    { 'value': 'amh', 'label': '阿姆哈拉语' },
    { 'value': 'arb', 'label': '现代标准阿拉伯语' },
    { 'value': 'ary', 'label': '摩洛哥阿拉伯语' },
    { 'value': 'arz', 'label': '埃及阿拉伯语' },
    { 'value': 'asm', 'label': '阿萨姆语' },
    { 'value': 'ast', 'label': '阿斯图里亚斯' },
    { 'value': 'azj', 'label': '北阿塞拜疆' },
    { 'value': 'bel', 'label': '白俄罗斯语' },
    { 'value': 'ben', 'label': '孟加拉语' },
    { 'value': 'bos', 'label': '波斯尼亚语' },
    { 'value': 'bul', 'label': '保加利亚语' },
    { 'value': 'cat', 'label': '加泰罗尼亚语' },
    { 'value': 'ceb', 'label': '宿务语' },
    { 'value': 'ces', 'label': '捷克语' },
    { 'value': 'ckb', 'label': '中央库尔德语' },
    { 'value': 'cym', 'label': '威尔士的' },
    { 'value': 'dan', 'label': '丹麦语' },
    { 'value': 'deu', 'label': '德国的' },
    { 'value': 'ell', 'label': '希腊人' },
    { 'value': 'est', 'label': '爱沙尼亚语' },
    { 'value': 'eus', 'label': '巴斯克' },
    { 'value': 'fin', 'label': '芬兰语' },
    { 'value': 'fra', 'label': '法语' },
    { 'value': 'gaz', 'label': '奥罗莫中西部' },
    { 'value': 'gle', 'label': '爱尔兰的' },
    { 'value': 'glg', 'label': '加利西亚语' },
    { 'value': 'guj', 'label': '古吉拉特语' },
    { 'value': 'heb', 'label': '希伯来语' },
    { 'value': 'hin', 'label': '印地语' },
    { 'value': 'hrv', 'label': '克罗地亚语' },
    { 'value': 'hun', 'label': '匈牙利语' },
    { 'value': 'hye', 'label': '亚美尼亚语' },
    { 'value': 'ibo', 'label': '伊博语' },
    { 'value': 'ind', 'label': '印尼语' },
    { 'value': 'isl', 'label': '冰岛语' },
    { 'value': 'ita', 'label': '意大利人' },
    { 'value': 'jav', 'label': '爪哇语' },
    { 'value': 'kam', 'label': '坎巴' },
    { 'value': 'kan', 'label': '卡纳达语' },
    { 'value': 'kat', 'label': '格鲁吉亚语' },
    { 'value': 'kaz', 'label': '哈萨克语' },
    { 'value': 'kea', 'label': '卡布佛得鲁文' },
    { 'value': 'khk', 'label': '哈尔蒙古族' },
    { 'value': 'khm', 'label': '高棉语' },
    { 'value': 'kir', 'label': '吉尔吉斯语' },
    { 'value': 'kor', 'label': '韩国人' },
    { 'value': 'lao', 'label': '老挝' },
    { 'value': 'lit', 'label': '立陶宛语' },
    { 'value': 'ltz', 'label': '卢森堡语' },
    { 'value': 'lug', 'label': '甘达' },
    { 'value': 'luo', 'label': '罗' },
    { 'value': 'lvs', 'label': '标准拉脱维亚语' },
    { 'value': 'mai', 'label': '迈蒂利语' },
    { 'value': 'mal', 'label': '马拉雅拉姆语' },
    { 'value': 'mar', 'label': '马拉地语' },
    { 'value': 'mkd', 'label': '马其顿语' },
    { 'value': 'mlt', 'label': '马耳他语' },
    { 'value': 'mni', 'label': '梅泰语' },
    { 'value': 'mya', 'label': '缅甸语' },
    { 'value': 'nld', 'label': '荷兰的' },
    { 'value': 'nno', 'label': '新挪威语' },
    { 'value': 'nob', 'label': '挪威语' },
    { 'value': 'npi', 'label': '尼泊尔语' },
    { 'value': 'nya', 'label': '南非语' },
    { 'value': 'oci', 'label': '奥克语' },
    { 'value': 'ory', 'label': '奥迪亚' },
    { 'value': 'pan', 'label': '旁遮普语' },
    { 'value': 'pbt', 'label': '南普什图语' },
    { 'value': 'pes', 'label': '西波斯语' },
    { 'value': 'pol', 'label': '磨光' },
    { 'value': 'por', 'label': '葡萄牙语' },
    { 'value': 'ron', 'label': '罗马尼亚语' },
    { 'value': 'rus', 'label': '俄语' },
    { 'value': 'slk', 'label': '斯洛伐克语' },
    { 'value': 'slv', 'label': '斯洛文尼亚语' },
    { 'value': 'sna', 'label': '肖纳' },
    { 'value': 'snd', 'label': '信德省' },
    { 'value': 'som', 'label': '索马里人' },
    { 'value': 'spa', 'label': '西班牙的' },
    { 'value': 'srp', 'label': '塞尔维亚语' },
    { 'value': 'swe', 'label': '瑞典的' },
    { 'value': 'swh', 'label': '斯瓦希里语' },
    { 'value': 'tam', 'label': '泰米尔语' },
    { 'value': 'tel', 'label': '泰卢固语' },
    { 'value': 'tgk', 'label': '塔吉克' },
    { 'value': 'tgl', 'label': '他加禄语' },
    { 'value': 'tha', 'label': '泰国人' },
    { 'value': 'tur', 'label': '土耳其的' },
    { 'value': 'ukr', 'label': '乌克兰语' },
    { 'value': 'urd', 'label': '乌尔都语' },
    { 'value': 'uzn', 'label': '北乌兹别克语' },
    { 'value': 'vie', 'label': '越南语' },
    { 'value': 'xho', 'label': '科萨' },
    { 'value': 'yor', 'label': '约鲁巴' },
    { 'value': 'yue', 'label': '广东话' },
    { 'value': 'zlm', 'label': '马来语口语' },
    { 'value': 'zsm', 'label': '标准马来语' },
    { 'value': 'zul', 'label': '祖鲁' }
  ];

  // textTarget = textSource
  List textSource = [
    { 'value': 'cmn', 'label': '普通话(中文)' },
    { 'value': 'eng', 'label': '英语' },
    { 'value': 'afr', 'label': '南非荷兰语' },
    { 'value': 'amh', 'label': '阿姆哈拉语' },
    { 'value': 'arb', 'label': '现代标准阿拉伯语' },
    { 'value': 'ary', 'label': '摩洛哥阿拉伯语' },
    { 'value': 'arz', 'label': '埃及阿拉伯语' },
    { 'value': 'asm', 'label': '阿萨姆语' },
    { 'value': 'azj', 'label': '北阿塞拜疆' },
    { 'value': 'bel', 'label': '白俄罗斯语' },
    { 'value': 'ben', 'label': '孟加拉语' },
    { 'value': 'bos', 'label': '波斯尼亚语' },
    { 'value': 'bul', 'label': '保加利亚语' },
    { 'value': 'cat', 'label': '加泰罗尼亚语' },
    { 'value': 'ceb', 'label': '宿务语' },
    { 'value': 'ces', 'label': '捷克语' },
    { 'value': 'ckb', 'label': '中央库尔德语' },
    { 'value': 'cym', 'label': '威尔士的' },
    { 'value': 'dan', 'label': '丹麦语' },
    { 'value': 'deu', 'label': '德国的' },
    { 'value': 'ell', 'label': '希腊人' },
    { 'value': 'est', 'label': '爱沙尼亚语' },
    { 'value': 'eus', 'label': '巴斯克' },
    { 'value': 'fin', 'label': '芬兰语' },
    { 'value': 'fra', 'label': '法语' },
    { 'value': 'gaz', 'label': '奥罗莫中西部' },
    { 'value': 'gle', 'label': '爱尔兰的' },
    { 'value': 'glg', 'label': '加利西亚语' },
    { 'value': 'guj', 'label': '古吉拉特语' },
    { 'value': 'heb', 'label': '希伯来语' },
    { 'value': 'hin', 'label': '印地语' },
    { 'value': 'hrv', 'label': '克罗地亚语' },
    { 'value': 'hun', 'label': '匈牙利语' },
    { 'value': 'hye', 'label': '亚美尼亚语' },
    { 'value': 'ibo', 'label': '伊博语' },
    { 'value': 'ind', 'label': '印尼语' },
    { 'value': 'isl', 'label': '冰岛语' },
    { 'value': 'ita', 'label': '意大利人' },
    { 'value': 'jav', 'label': '爪哇语' },
    { 'value': 'jpn', 'label': '日本語' },
    { 'value': 'kan', 'label': '卡纳达语' },
    { 'value': 'kat', 'label': '格鲁吉亚语' },
    { 'value': 'kaz', 'label': '哈萨克语' },
    { 'value': 'khk', 'label': '哈尔蒙古族' },
    { 'value': 'khm', 'label': '高棉语' },
    { 'value': 'kir', 'label': '吉尔吉斯语' },
    { 'value': 'kor', 'label': '韩国人' },
    { 'value': 'lao', 'label': '老挝' },
    { 'value': 'lit', 'label': '立陶宛语' },
    { 'value': 'lug', 'label': '甘达' },
    { 'value': 'luo', 'label': '罗' },
    { 'value': 'lvs', 'label': '标准拉脱维亚语' },
    { 'value': 'mai', 'label': '迈蒂利语' },
    { 'value': 'mal', 'label': '马拉雅拉姆语' },
    { 'value': 'mar', 'label': '马拉地语' },
    { 'value': 'mkd', 'label': '马其顿语' },
    { 'value': 'mlt', 'label': '马耳他语' },
    { 'value': 'mni', 'label': '梅泰语' },
    { 'value': 'mya', 'label': '缅甸语' },
    { 'value': 'nld', 'label': '荷兰的' },
    { 'value': 'nno', 'label': '新挪威语' },
    { 'value': 'nob', 'label': '挪威语' },
    { 'value': 'npi', 'label': '尼泊尔语' },
    { 'value': 'nya', 'label': '南非语' },
    { 'value': 'ory', 'label': '奥迪亚' },
    { 'value': 'pan', 'label': '旁遮普语' },
    { 'value': 'pbt', 'label': '南普什图语' },
    { 'value': 'pes', 'label': '西波斯语' },
    { 'value': 'pol', 'label': '磨光' },
    { 'value': 'por', 'label': '葡萄牙语' },
    { 'value': 'ron', 'label': '罗马尼亚语' },
    { 'value': 'rus', 'label': '俄语' },
    { 'value': 'slk', 'label': '斯洛伐克语' },
    { 'value': 'slv', 'label': '斯洛文尼亚语' },
    { 'value': 'sna', 'label': '肖纳' },
    { 'value': 'snd', 'label': '信德省' },
    { 'value': 'som', 'label': '索马里人' },
    { 'value': 'spa', 'label': '西班牙的' },
    { 'value': 'srp', 'label': '塞尔维亚语' },
    { 'value': 'swe', 'label': '瑞典的' },
    { 'value': 'swh', 'label': '斯瓦希里语' },
    { 'value': 'tam', 'label': '泰米尔语' },
    { 'value': 'tel', 'label': '泰卢固语' },
    { 'value': 'tgk', 'label': '塔吉克' },
    { 'value': 'tgl', 'label': '他加禄语' },
    { 'value': 'tha', 'label': '泰国人' },
    { 'value': 'tur', 'label': '土耳其的' },
    { 'value': 'ukr', 'label': '乌克兰语' },
    { 'value': 'urd', 'label': '乌尔都语' },
    { 'value': 'uzn', 'label': '北乌兹别克语' },
    { 'value': 'vie', 'label': '越南语' },
    { 'value': 'yor', 'label': '约鲁巴' },
    { 'value': 'yue', 'label': '广东话' },
    { 'value': 'zsm', 'label': '标准马来语' },
    { 'value': 'zul', 'label': '祖鲁' },
  ];

  List speechTarget = [
    { 'value': 'eng', 'label': '英语' },
    { 'value': 'cmn', 'label': '普通话(中文)' },
    { 'value': 'arb', 'label': '现代标准阿拉伯语' },
    { 'value': 'ben', 'label': '孟加拉语' },
    { 'value': 'cat', 'label': '加泰罗尼亚语' },
    { 'value': 'ces', 'label': '捷克语' },
    { 'value': 'cym', 'label': '威尔士的' },
    { 'value': 'dan', 'label': '丹麦语' },
    { 'value': 'deu', 'label': '德国的' },
    { 'value': 'est', 'label': '爱沙尼亚语' },
    { 'value': 'fin', 'label': '芬兰语' },
    { 'value': 'fra', 'label': '法语' },
    { 'value': 'hin', 'label': '印地语' },
    { 'value': 'ind', 'label': '印尼语' },
    { 'value': 'ita', 'label': '意大利人' },
    { 'value': 'jpn', 'label': '日本語' },
    { 'value': 'kor', 'label': '韩国人' },
    { 'value': 'mlt', 'label': '马耳他语' },
    { 'value': 'nld', 'label': '荷兰的' },
    { 'value': 'pes', 'label': '西波斯语' },
    { 'value': 'pol', 'label': '磨光' },
    { 'value': 'por', 'label': '葡萄牙语' },
    { 'value': 'ron', 'label': '罗马尼亚语' },
    { 'value': 'rus', 'label': '俄语' },
    { 'value': 'slk', 'label': '斯洛伐克语' },
    { 'value': 'spa', 'label': '西班牙的' },
    { 'value': 'swe', 'label': '瑞典的' },
    { 'value': 'swh', 'label': '斯瓦希里语' },
    { 'value': 'tel', 'label': '泰卢固语' },
    { 'value': 'tgl', 'label': '他加禄语' },
    { 'value': 'tha', 'label': '泰国人' },
    { 'value': 'tur', 'label': '土耳其的' },
    { 'value': 'ukr', 'label': '乌克兰语' },
    { 'value': 'urd', 'label': '乌尔都语' },
    { 'value': 'uzn', 'label': '北乌兹别克语' },
    { 'value': 'vie', 'label': '越南语' },
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
