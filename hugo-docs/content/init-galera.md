+++
date = "2017-06-11T13:06:09-04:00"
description = "init galera node log output"
title = "init_galera.log"

[menu]

  [menu.main]
    identifier = "initgalera"
    parent = "code"
    weight = 11

+++

Result from running `./init-galera && docker attach --sig-proxy=false irods-galera-1`.

```console
$ ./init-galera && docker attach --sig-proxy=false irods-galera-1
Error response from daemon: No such container: irods-galera-1
Error response from daemon: No such container: irods-galera-1
Unable to find image 'mjstealey/irods-provider-galera:latest' locally
latest: Pulling from mjstealey/irods-provider-galera
343b09361036: Pull complete
608343e5b0d0: Pull complete
91fb8ae89fb7: Pull complete
9b44cff09138: Pull complete
97f8885c0109: Pull complete
98c739205832: Pull complete
c00b8088a5b0: Pull complete
aa14f35a131e: Pull complete
eef6ac74c481: Pull complete
05f7faacbe7b: Pull complete
d1825e2b39bf: Pull complete
ce53a734ec4c: Pull complete
234f1b6d7574: Pull complete
22cad25b9d82: Pull complete
c75107fa70f4: Pull complete
f0e8dae58db7: Pull complete
Digest: sha256:eabb3b7f672403da5402d524b767bdb79db6cd66242600f192cc96369deaa67d
Status: Downloaded newer image for mjstealey/irods-provider-galera:latest
203fd120fd2a7169edfb265384b324516c50073a25203538a3d36f58db23c049
./ib_logfile0
./aria_log_control
./test/
./mysql/
./mysql/innodb_index_stats.ibd
./mysql/time_zone_transition.frm
./mysql/procs_priv.frm
./mysql/general_log.CSV
./mysql/host.frm
./mysql/table_stats.frm
./mysql/servers.MYI
./mysql/innodb_table_stats.frm
./mysql/columns_priv.frm
./mysql/proxies_priv.MYI
./mysql/proc.MYD
./mysql/column_stats.MYI
./mysql/db.MYI
./mysql/help_category.MYI
./mysql/help_topic.frm
./mysql/event.frm
./mysql/proc.MYI
./mysql/host.MYD
./mysql/innodb_table_stats.ibd
./mysql/help_relation.MYI
./mysql/plugin.MYI
./mysql/slow_log.CSM
./mysql/help_relation.MYD
./mysql/help_category.frm
./mysql/time_zone_name.frm
./mysql/proxies_priv.MYD
./mysql/help_keyword.MYI
./mysql/servers.frm
./mysql/columns_priv.MYI
./mysql/plugin.frm
./mysql/index_stats.frm
./mysql/func.MYI
./mysql/tables_priv.frm
./mysql/gtid_slave_pos.frm
./mysql/time_zone_leap_second.MYD
./mysql/host.MYI
./mysql/help_topic.MYI
./mysql/table_stats.MYD
./mysql/procs_priv.MYI
./mysql/help_keyword.MYD
./mysql/tables_priv.MYD
./mysql/roles_mapping.MYI
./mysql/column_stats.MYD
./mysql/procs_priv.MYD
./mysql/help_category.MYD
./mysql/user.MYD
./mysql/time_zone_transition_type.MYI
./mysql/index_stats.MYI
./mysql/db.frm
./mysql/func.MYD
./mysql/time_zone_transition.MYD
./mysql/columns_priv.MYD
./mysql/roles_mapping.MYD
./mysql/time_zone_transition_type.MYD
./mysql/column_stats.frm
./mysql/time_zone.frm
./mysql/user.MYI
./mysql/general_log.frm
./mysql/help_keyword.frm
./mysql/table_stats.MYI
./mysql/plugin.MYD
./mysql/tables_priv.MYI
./mysql/time_zone_name.MYI
./mysql/func.frm
./mysql/gtid_slave_pos.ibd
./mysql/slow_log.CSV
./mysql/proc.frm
./mysql/time_zone_name.MYD
./mysql/time_zone_transition.MYI
./mysql/time_zone_transition_type.frm
./mysql/time_zone_leap_second.frm
./mysql/db.MYD
./mysql/slow_log.frm
./mysql/general_log.CSM
./mysql/index_stats.MYD
./mysql/event.MYD
./mysql/servers.MYD
./mysql/proxies_priv.frm
./mysql/help_topic.MYD
./mysql/time_zone.MYD
./mysql/roles_mapping.frm
./mysql/help_relation.frm
./mysql/time_zone.MYI
./mysql/innodb_index_stats.frm
./mysql/user.frm
./mysql/time_zone_leap_second.MYI
./mysql/event.MYI
./aria_log.00000001
./ibdata1
./performance_schema/
./performance_schema/db.opt
/
!!! populating /var/lib/irods with initial contents !!!
./
./scripts/
./scripts/irods/
./scripts/irods/upgrade_configuration.py
./scripts/irods/setup_options.py
./scripts/irods/core_file.py
./scripts/irods/log.py
./scripts/irods/paths.py
./scripts/irods/json_validation.py
./scripts/irods/database_upgrade.py
./scripts/irods/test/
./scripts/irods/test/rule_texts_for_tests.py
./scripts/irods/test/test_irsync.py
./scripts/irods/test/test_control_plane.py
./scripts/irods/test/test_rulebase.py
./scripts/irods/test/test_catalog.py
./scripts/irods/test/test_federation.py
./scripts/irods/test/command.py
./scripts/irods/test/test_igroupadmin.py
./scripts/irods/test/test_irodsctl.py
./scripts/irods/test/test_iadmin.py
./scripts/irods/test/test_all_rules.py
./scripts/irods/test/test_load_balanced_suite.py
./scripts/irods/test/test_chunkydevtest.py
./scripts/irods/test/settings.py
./scripts/irods/test/test_ils.py
./scripts/irods/test/test_iphymv.py
./scripts/irods/test/metaclass_unittest_test_case_generator.py
./scripts/irods/test/test_quotas.py
./scripts/irods/test/test_resource_types.py
./scripts/irods/test/test_client_hints.py
./scripts/irods/test/test_ireg.py
./scripts/irods/test/test_native_rule_engine_plugin.py
./scripts/irods/test/test_iput_options.py
./scripts/irods/test/test_icommands_file_operations.py
./scripts/irods/test/test_irmdir.py
./scripts/irods/test/test_auth.py
./scripts/irods/test/test_xmsg.py
./scripts/irods/test/session.py
./scripts/irods/test/resource_suite.py
./scripts/irods/test/test_compatibility.py
./scripts/irods/test/test_iscan.py
./scripts/irods/test/test_iticket.py
./scripts/irods/test/test_resource_tree.py
./scripts/irods/test/test_ipasswd.py
./scripts/irods/test/test_resource_configuration.py
./scripts/irods/test/test_ichmod.py
./scripts/irods/test/test_iquest.py
./scripts/irods/test/test_imeta_set.py
./scripts/irods/test/test_faulty_filesystem.py
./scripts/irods/test/README
./scripts/irods/test/__init__.py
./scripts/irods/database_connect.py
./scripts/irods/__init__.pyc
./scripts/irods/convert_configuration_to_json.py
./scripts/irods/exceptions.py
./scripts/irods/six.py
./scripts/irods/lib.py
./scripts/irods/password_obfuscation.py
./scripts/irods/paths.pyc
./scripts/irods/pypyodbc.py
./scripts/irods/configuration.py
./scripts/irods/controller.py
./scripts/irods/pyparsing.py
./scripts/irods/__init__.py
./scripts/irods/database_interface.py
./scripts/irods/start_options.py
./scripts/validate_json.py
./scripts/rulebase_fastswap_test_2276.sh
./scripts/chown_directories_for_postinstall.py
./scripts/make_resource_tree.py
./scripts/manual_cleanup.py
./scripts/pid_age.py
./scripts/find_shared_object.py
./scripts/terminate_irods_processes.py
./scripts/switchuser.py
./scripts/irods_control.py
./scripts/setup_irods.py
./scripts/system_identification.py
./scripts/run_coverage_test.sh
./scripts/get_irods_version.py
./scripts/cleanup_resource_tree.py
./scripts/run_cppcheck.sh
./scripts/kill_pid.py
./scripts/run_tests.py
./scripts/get_db_schema_version.py
./VERSION.json.dist
./test/
./test/filesystem/
./test/filesystem/teardown_fs.sh
./test/filesystem/setup_fs.sh
./test/filesystem/make_sector_mapping_table.py
./test/filesystem/mapping.txt
./test/test_framework_configuration.json
./irodsctl
./packaging/
./packaging/sql/
./packaging/sql/icatPurgeRecycleBin.sql
./packaging/sql/mysql_functions.sql
./packaging/sql/icatDropSysTables.sql
./packaging/sql/icatSysTables.sql
./packaging/sql/icatSysInserts.sql
./packaging/hosts_config.json.template
./packaging/irodsMonPerf.config.in
./packaging/core.fnm.template
./packaging/find_os.sh
./packaging/core.dvm.template
./packaging/server_config.json.template
./packaging/host_access_control_config.json.template
./packaging/upgrade-3.3.xto4.0.0.sql
./packaging/postinstall.sh
./packaging/server_setup_instructions.txt
./packaging/connectControl.config.template
./packaging/database_config.json.template
./packaging/localhost_setup_mysql.input
./packaging/preremove.sh
./packaging/core.re.template
./configuration_schemas/
./configuration_schemas/v3/
./configuration_schemas/v3/configuration_directory.json
./configuration_schemas/v3/hosts_config.json
./configuration_schemas/v3/server.json
./configuration_schemas/v3/server_status.json
./configuration_schemas/v3/resource.json
./configuration_schemas/v3/client_hints.json
./configuration_schemas/v3/VERSION.json
./configuration_schemas/v3/rule_engine.json
./configuration_schemas/v3/database_config.json
./configuration_schemas/v3/plugin.json
./configuration_schemas/v3/zone_bundle.json
./configuration_schemas/v3/grid_status.json
./configuration_schemas/v3/host_access_control_config.json
./configuration_schemas/v3/server_config.json
./configuration_schemas/v3/client_environment.json
./configuration_schemas/v3/service_account_environment.json
./msiExecCmd_bin/
./msiExecCmd_bin/univMSSInterface.sh
./msiExecCmd_bin/hello
./msiExecCmd_bin/test_execstream.py
./msiExecCmd_bin/irodsServerMonPerf
./clients/
./clients/icommands/
./clients/icommands/test/
./clients/icommands/test/misc/
./clients/icommands/test/misc/devtestuser-account-ACL.txt
./clients/icommands/test/misc/email.tag
./clients/icommands/test/misc/sample.email
./clients/icommands/test/misc/load-metadata.txt
./clients/icommands/test/misc/load-usermods.txt
./clients/icommands/test/rules/
./clients/icommands/test/rules/rulemsiSetMultiReplPerResc.r
./clients/icommands/test/rules/rulemsiCollRsync.r
./clients/icommands/test/rules/rulemsiReadMDTemplateIntoTagStruct.r
./clients/icommands/test/rules/rulemsiobjget_z3950.r
./clients/icommands/test/rules/rulemsiIp2location.r
./clients/icommands/test/rules/rulemsiGetUserInfo.r
./clients/icommands/test/rules/rulemsiDataObjGet.r
./clients/icommands/test/rules/rulemsiRegisterData.r
./clients/icommands/test/rules/rulemsiQuota.r
./clients/icommands/test/rules/rulemsiGetSessionVarValue.r
./clients/icommands/test/rules/rulemsiGetUserACL.r
./clients/icommands/test/rules/rulemsiCreateUser.r
./clients/icommands/test/rules/rulemsiFlagInfectedObjs.r
./clients/icommands/test/rules/rulemsiNoTrashCan.r
./clients/icommands/test/rules/rulemsiSplitPath.r
./clients/icommands/test/rules/rulemsiSetBulkPutPostProcPolicy.r
./clients/icommands/test/rules/rulemsiGetCollectionContentsReport.r
./clients/icommands/test/rules/rulemsiXmsgServerConnect.r
./clients/icommands/test/rules/rulemsiRenameCollection.r
./clients/icommands/test/rules/rulemsiSetDefaultResc.r
./clients/icommands/test/rules/rulemsiImageConvert.r
./clients/icommands/test/rules/rulemsiWriteRodsLog.r
./clients/icommands/test/rules/rulemsiCollCreate.r
./clients/icommands/test/rules/rulemsiAddConditionToGenQuery.r
./clients/icommands/test/rules/testsuite3.r
./clients/icommands/test/rules/rulemsiobjput_srb.r
./clients/icommands/test/rules/rulemsiMakeGenQuery.r
./clients/icommands/test/rules/rulemsiObjStat.r
./clients/icommands/test/rules/rulemsiExecGenQuery.r
./clients/icommands/test/rules/rulemsiAddSelectFieldToGenQuery.r
./clients/icommands/test/rules/rulemsiSetNumThreads.r
./clients/icommands/test/rules/rulemsiRecursiveCollCopy.r
./clients/icommands/test/rules/rulemsiStrchop.r
./clients/icommands/test/rules/rulemsiobjget_slink.r
./clients/icommands/test/rules/rulemsiSendMail.r
./clients/icommands/test/rules/rulemsiImageConvert-no-properties.r
./clients/icommands/test/rules/rulemsiImageConvert-compression.r
./clients/icommands/test/rules/rulemsiSubstr.r
./clients/icommands/test/rules/rulemsiStrArray2String.r
./clients/icommands/test/rules/rulemsiSysReplDataObj.r
./clients/icommands/test/rules/rulegenerateBagIt.r
./clients/icommands/test/rules/rulemsiPropertiesRemove.r
./clients/icommands/test/rules/rulemsiPhyBundleColl.r
./clients/icommands/test/rules/rulewriteXMsg.r
./clients/icommands/test/rules/testsuite1.r
./clients/icommands/test/rules/rulemsiDeleteUser.r
./clients/icommands/test/rules/rulemsiDataObjUnlink.r
./clients/icommands/test/rules/ruleintegrityExpiry.r
./clients/icommands/test/rules/rulemsiTwitterPost.r
./clients/icommands/test/rules/rulemsiGetCollectionSize.r
./clients/icommands/test/rules/rulemsiDataObjOpen.r
./clients/icommands/test/rules/rulemsiNoChkFilePathPerm.r
./clients/icommands/test/rules/rulemsiPropertiesClear.r
./clients/icommands/test/rules/rulemsiGetDataObjPSmeta.r
./clients/icommands/test/rules/rulemsiGetObjType.r
./clients/icommands/test/rules/rulemsiRmColl.r
./clients/icommands/test/rules/rulemsiSetRandomScheme.r
./clients/icommands/test/rules/rulemsiobjget_http.r
./clients/icommands/test/rules/rulemsiGetDataObjAVUs.r
./clients/icommands/test/rules/rulemsiGetDataObjAIP.r
./clients/icommands/test/rules/ruleintegrityDataType.r
./clients/icommands/test/rules/rulemsiPropertiesNew.r
./clients/icommands/test/rules/rulemsiFreeBuffer.r
./clients/icommands/test/rules/rulemsiSetDataObjPreferredResc.r
./clients/icommands/test/rules/rulemsiPropertiesAdd.r
./clients/icommands/test/rules/ruleTestChangeSessionVar.r
./clients/icommands/test/rules/rulemsiDataObjRename.r
./clients/icommands/test/rules/rulereadXMsg.r
./clients/icommands/test/rules/rulemsiGetFormattedSystemTime.r
./clients/icommands/test/rules/rulewritePosInt.r
./clients/icommands/test/rules/rulemsiobjput_http.r
./clients/icommands/test/rules/rulemsiSetRescQuotaPolicy.r
./clients/icommands/test/rules/rulemsiPropertiesExists.r
./clients/icommands/test/rules/rulemsiPrintGenQueryOutToBuffer.r
./clients/icommands/test/rules/rulemsiObjByName.r
./clients/icommands/test/rules/rulemsiAclPolicy.r
./clients/icommands/test/rules/rulemsiSetPublicUserOpr.r
./clients/icommands/test/rules/rulemsiApplyDCMetadataTemplate.r
./clients/icommands/test/rules/rulemsiSetGraftPathScheme.r
./clients/icommands/test/rules/rulemsiGetAuditTrailInfoByUserID.r
./clients/icommands/test/rules/rulemsiRollback.r
./clients/icommands/test/rules/rulemsiSetReServerNumProc.r
./clients/icommands/test/rules/rulemsiSleep.r
./clients/icommands/test/rules/rulemsiLoadMetadataFromXml.r
./clients/icommands/test/rules/rulemsiSendXmsg.r
./clients/icommands/test/rules/rulemsiz3950Submit.r
./clients/icommands/test/rules/rulemsiSortDataObj.r
./clients/icommands/test/rules/rulemsiXmsgServerDisConnect.r
./clients/icommands/test/rules/rulemsiDataObjRsync.r
./clients/icommands/test/rules/rulemsiGetCollectionACL.r
./clients/icommands/test/rules/rulemsiTarFileCreate.r
./clients/icommands/test/rules/rulemsiAssociateKeyValuePairsToObj.r
./clients/icommands/test/rules/rulemsiGetDiffTime.r
./clients/icommands/test/rules/rulemsiStructFileBundle.r
./clients/icommands/test/rules/rulemsiListEnabledMS.r
./clients/icommands/test/rules/ruleintegrityACL.r
./clients/icommands/test/rules/rulemsiSetDataObjAvoidResc.r
./clients/icommands/test/rules/rulemsiGetStdoutInExecCmdOut.r
./clients/icommands/test/rules/rulemsiHumanToSystemTime.r
./clients/icommands/test/rules/rulemsiPropertiesClone.r
./clients/icommands/test/rules/rulemsiDeleteUnusedAVUs.r
./clients/icommands/test/rules/rulemsiIsColl.r
./clients/icommands/test/rules/rulemsiCommit.r
./clients/icommands/test/rules/rulemsiDataObjRead.r
./clients/icommands/test/rules/rulemsiGetMoreRows.r
./clients/icommands/test/rules/rulemsiSysChksumDataObj.r
./clients/icommands/test/rules/rulewriteKeyValPairs.r
./clients/icommands/test/rules/rulemsiobjput_z3950.r
./clients/icommands/test/rules/rulemsiMergeDataCopies.r
./clients/icommands/test/rules/rulemsiServerMonPerf.r
./clients/icommands/test/rules/rulemsiCopyAVUMetadata.r
./clients/icommands/test/rules/rulemsiFlagDataObjwithAVU.r
./clients/icommands/test/rules/rulemsiDataObjLseek.r
./clients/icommands/test/rules/rulemsiStoreVersionWithTS.r
./clients/icommands/test/rules/rulemsiExportRecursiveCollMeta.r
./clients/icommands/test/rules/rulemsiGetCollectionPSmeta-null.r
./clients/icommands/test/rules/rulemsiGetValByKey.r
./clients/icommands/test/rules/rulemsiExit.r
./clients/icommands/test/rules/rulemsiobjget_irods.r
./clients/icommands/test/rules/rulemsiCheckAccess.r
./clients/icommands/test/rules/rulemsiLoadUserModsFromDataObj.r
./clients/icommands/test/rules/rulemsiExtractTemplateMDFromBuf.r
./clients/icommands/test/rules/rulemsiCheckPermission.r
./clients/icommands/test/rules/rulemsiPropertiesToString.r
./clients/icommands/test/rules/rulemsiDoSomething.r
./clients/icommands/test/rules/rulemsiGetAuditTrailInfoByKeywords.r
./clients/icommands/test/rules/rulewriteString.r
./clients/icommands/test/rules/rulemsiSetACL.r
./clients/icommands/test/rules/rulemsiLoadMetadataFromDataObj.r
./clients/icommands/test/rules/rulemsiSetResource.r
./clients/icommands/test/rules/rulemsiIsData.r
./clients/icommands/test/rules/rulemsiString2StrArray.r
./clients/icommands/test/rules/rulewriteLine.r
./clients/icommands/test/rules/rulemsiCheckOwner.r
./clients/icommands/test/rules/rulemsiRcvXmsg.r
./clients/icommands/test/rules/test_no_memory_error_patch_2242.r
./clients/icommands/test/rules/rulemsiDataObjUnlink-trash.r
./clients/icommands/test/rules/ruleintegrityFileSize.r
./clients/icommands/test/rules/rulemsiobjget_srb.r
./clients/icommands/test/rules/testsuite2.r
./clients/icommands/test/rules/rulemsiPrintKeyValPair.r
./clients/icommands/test/rules/rulemsiGetFormattedSystemTime-human.r
./clients/icommands/test/rules/rulemsiCollRepl.r
./clients/icommands/test/rules/rulemsiDeleteUsersFromDataObj.r
./clients/icommands/test/rules/rulemsiDataObjPhymv.r
./clients/icommands/test/rules/rulemsiSetNoDirectRescInp.r
./clients/icommands/test/rules/rulemsiobjput_test.r
./clients/icommands/test/rules/rulemsiPhyPathReg.r
./clients/icommands/test/rules/rulemsiSetQuota.r
./clients/icommands/test/rules/rulemsiGetDataObjACL.r
./clients/icommands/test/rules/rulemsiDataObjClose.r
./clients/icommands/test/rules/rulemsiDataObjTrim.r
./clients/icommands/test/rules/rulemsiAddKeyVal.r
./clients/icommands/test/rules/rulemsiPropertiesFromString.r
./clients/icommands/test/rules/rulemsiDeleteDisallowed.r
./clients/icommands/test/rules/rulemsiDataObjChksum.r
./clients/icommands/test/rules/rulemsiImageGetProperties.r
./clients/icommands/test/rules/rulemsiCollectionSpider.r
./clients/icommands/test/rules/rulemsiStageDataObj.r
./clients/icommands/test/rules/rulemsiExecStrCondQuery.r
./clients/icommands/test/rules/rulemsiAddKeyValToMspStr.r
./clients/icommands/test/rules/rulemsiDataObjCopy.r
./clients/icommands/test/rules/rulemsiCreateUserAccountsFromDataObj.r
./clients/icommands/test/rules/rulemsiSetReplComment.r
./clients/icommands/test/rules/rulemsiAddUserToGroup.r
./clients/icommands/test/rules/rulemsiGetQuote.r
./clients/icommands/test/rules/rulemsiGetStderrInExecCmdOut.r
./clients/icommands/test/rules/rulemsiSysMetaModify.r
./clients/icommands/test/rules/rulemsiExecCmd.r
./clients/icommands/test/rules/ruleintegrityAVU.r
./clients/icommands/test/rules/rulemsiGetCollectionPSmeta.r
./clients/icommands/test/rules/rulemsiCheckHostAccessControl.r
./clients/icommands/test/rules/nqueens.r
./clients/icommands/test/rules/rulemsiFtpGet.r
./clients/icommands/test/rules/rulemsiGetObjectPath.r
./clients/icommands/test/rules/rulemsiMakeQuery.r
./clients/icommands/test/rules/rulemsiXmsgCreateStream.r
./clients/icommands/test/rules/rulemsiGetSystemTime.r
./clients/icommands/test/rules/rulemsiSdssImgCutout_GetJpeg.r
./clients/icommands/test/rules/rulemsiDataObjRepl.r
./clients/icommands/test/rules/rulemsiGoodFailure.r
./clients/icommands/test/rules/rulemsiDataObjWrite.r
./clients/icommands/test/rules/rulemsiGetAuditTrailInfoByObjectID.r
./clients/icommands/test/rules/rulemsiStripAVUs.r
./clients/icommands/test/rules/rulemsiTarFileExtract.r
./clients/icommands/test/rules/rulemsiobjput_irods.r
./clients/icommands/test/rules/rulemsiOprDisallowed.r
./clients/icommands/test/rules/ruleprint_hello.r
./clients/icommands/test/rules/testsuiteForLcov.r
./clients/icommands/test/rules/rulemsiGetTaggedValueFromString.r
./clients/icommands/test/rules/rulemsiPrintGenQueryInp.r
./clients/icommands/test/rules/rulemsiRemoveKeyValuePairsFromObj.r
./clients/icommands/test/rules/rulemsiXmlDocSchemaValidate.r
./clients/icommands/test/rules/rulemsiLoadACLFromDataObj.r
./clients/icommands/test/rules/rulemsiDigestMonStat.r
./clients/icommands/test/rules/rulemsiobjget_test.r
./clients/icommands/test/rules/rulemsiExtractNaraMetadata.r
./clients/icommands/test/rules/rulemsiStrToBytesBuf.r
./clients/icommands/test/rules/rulemsiSplitPathByKey.r
./clients/icommands/test/rules/rulemsiSetRescSortScheme.r
./clients/icommands/test/rules/rulemsiRenameLocalZone.r
./clients/icommands/test/rules/rulemsiString2KeyValPair.r
./clients/icommands/test/rules/rulewriteBytesBuf.r
./clients/icommands/test/rules/rulemsiDataObjCreate.r
./clients/icommands/test/rules/rulemsiConvertCurrency.r
./clients/icommands/test/rules/rulemsiGetAuditTrailInfoByTimeStamp.r
./clients/icommands/test/rules/rulemsiStrlen.r
./clients/icommands/test/rules/rulemsiSetDataType.r
./clients/icommands/test/rules/rulemsiGuessDataType.r
./clients/icommands/test/rules/rulemsiXsltApply.r
./clients/icommands/test/rules/rulemsiGetAuditTrailInfoByActionID.r
./clients/icommands/test/rules/rulemsiStrCat.r
./clients/icommands/test/rules/rulemsiDeleteCollByAdmin.r
./clients/icommands/test/rules/rulemsiPropertiesGet.r
./clients/icommands/test/rules/rulemsiFlushMonStat.r
./clients/icommands/test/rules/rulemsiGetIcatTime.r
./clients/icommands/test/rules/rulemsiSetDataTypeFromExt.r
./clients/icommands/test/rules/ruleintegrityAVUvalue.r
./clients/icommands/test/rules/rulemsiCreateXmsgInp.r
./clients/icommands/test/rules/rulemsiPropertiesSet.r
./clients/icommands/test/rules/rulemsiobjput_slink.r
./clients/icommands/test/rules/rulemsiCreateCollByAdmin.r
./clients/icommands/test/rules/rulemsiGetContInxFromGenQueryOut.r
./clients/icommands/test/rules/rulemsiDataObjPut.r
./clients/icommands/test/rules/ruleintegrityFileOwner.r
./clients/bin/
./clients/bin/genOSAuth
./config/
./config/lockFileDir/
./config/packedRei/
./log/
/
Starting MySQL.170611 16:59:51 mysqld_safe Logging to '/var/lib/mysql/galera-1.edc.renci.org.err'.
170611 16:59:51 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
 SUCCESS!
exec mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user.  If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

stty: standard input: Inappropriate ioctl for device
Enter current password for root (enter for none):
stty: standard input: Inappropriate ioctl for device
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

Set root password? [Y/n] stty: standard input: Inappropriate ioctl for device
New password:
Re-enter new password:
stty: standard input: Inappropriate ioctl for device
Password updated successfully!
Reloading privilege tables..
 ... Success!


By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n]  ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n]  ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n]  - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n]  ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
Grants for irods@localhost
GRANT USAGE ON *.* TO 'irods'@'localhost' IDENTIFIED BY PASSWORD '*60E38376E2C974797971A03D9BEEF1F5EB169FEA'
GRANT ALL PRIVILEGES ON `ICAT`.* TO 'irods'@'localhost'
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /usr/bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking build system type... x86_64-unknown-linux-gnu
checking host system type... x86_64-unknown-linux-gnu
checking how to print strings... printf
checking for style of include used by make... GNU
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking dependency style of gcc... gcc3
checking for a sed that does not truncate output... /usr/bin/sed
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for fgrep... /usr/bin/grep -F
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+="... yes
checking how to convert x86_64-unknown-linux-gnu file names to x86_64-unknown-linux-gnu format... func_convert_file_noop
checking how to convert x86_64-unknown-linux-gnu file names to toolchain format... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... dlltool
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for sysroot... no
./configure: line 6607: /usr/bin/file: No such file or directory
checking for mt... no
checking if : is a manifest tool... no
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... yes
checking if gcc static flag -static works... no
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/usr/bin/ld) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking for gcc... (cached) gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to accept ISO C89... (cached) none needed
checking dependency style of gcc... (cached) gcc3
checking for mysqlbin... ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: NO)
which: no mysqltest in (/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin)
dirname: missing operand
Try 'dirname --help' for more information.
checking for mysql_config... /usr/bin/mysql_config
checking for MySQL libraries... yes
configure: setting libdir to mysql plugin dir /usr/lib64/mysql/plugin
checking for pcre-config... /usr/bin/pcre-config
checking for PCRE - version >= 1... 8.32
checking for the pthreads library -lpthread... yes
checking for joinable pthread attribute... PTHREAD_CREATE_JOINABLE
checking if more special flags are required for pthreads... no
checking for PTHREAD_PRIO_INHERIT... yes
checking for pthread_attr_setstacksize... yes
checking for pthread_attr_get_np... no
checking for pthread_getattr_np... yes
checking for pthread_getattr_np declaration... missing
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating test/Makefile
config.status: creating doc/Makefile
config.status: creating config.h
config.status: executing depfiles commands
config.status: executing libtool commands
(CDPATH="${ZSH_VERSION+.}:" && cd . && /bin/sh /lib_mysqludf_preg/config/missing autoheader)
rm -f stamp-h1
touch config.h.in
cd . && /bin/sh ./config.status config.h
config.status: creating config.h
config.status: config.h is unchanged
make  all-recursive
make[1]: Entering directory `/lib_mysqludf_preg'
Making all in test
make[2]: Entering directory `/lib_mysqludf_preg/test'
make[3]: Entering directory `/lib_mysqludf_preg'
make[3]: Leaving directory `/lib_mysqludf_preg'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/lib_mysqludf_preg/test'
Making all in doc
make[2]: Entering directory `/lib_mysqludf_preg/doc'
make[3]: Entering directory `/lib_mysqludf_preg'
make[3]: Leaving directory `/lib_mysqludf_preg'
make[2]: Nothing to be done for `all'.
make[2]: Leaving directory `/lib_mysqludf_preg/doc'
make[2]: Entering directory `/lib_mysqludf_preg'
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-preg.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-preg.Tpo -c -o lib_mysqludf_preg_la-preg.lo `test -f 'preg.c' || echo './'`preg.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-preg.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-preg.Tpo -c preg.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-preg.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-preg.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-preg.Tpo -c preg.c -o lib_mysqludf_preg_la-preg.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-preg.Tpo .deps/lib_mysqludf_preg_la-preg.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-preg_utils.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-preg_utils.Tpo -c -o lib_mysqludf_preg_la-preg_utils.lo `test -f 'preg_utils.c' || echo './'`preg_utils.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-preg_utils.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-preg_utils.Tpo -c preg_utils.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-preg_utils.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-preg_utils.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-preg_utils.Tpo -c preg_utils.c -o lib_mysqludf_preg_la-preg_utils.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-preg_utils.Tpo .deps/lib_mysqludf_preg_la-preg_utils.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-ghmysql.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-ghmysql.Tpo -c -o lib_mysqludf_preg_la-ghmysql.lo `test -f 'ghmysql.c' || echo './'`ghmysql.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-ghmysql.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-ghmysql.Tpo -c ghmysql.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-ghmysql.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-ghmysql.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-ghmysql.Tpo -c ghmysql.c -o lib_mysqludf_preg_la-ghmysql.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-ghmysql.Tpo .deps/lib_mysqludf_preg_la-ghmysql.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-ghfcns.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-ghfcns.Tpo -c -o lib_mysqludf_preg_la-ghfcns.lo `test -f 'ghfcns.c' || echo './'`ghfcns.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-ghfcns.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-ghfcns.Tpo -c ghfcns.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-ghfcns.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-ghfcns.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-ghfcns.Tpo -c ghfcns.c -o lib_mysqludf_preg_la-ghfcns.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-ghfcns.Tpo .deps/lib_mysqludf_preg_la-ghfcns.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-from_php.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-from_php.Tpo -c -o lib_mysqludf_preg_la-from_php.lo `test -f 'from_php.c' || echo './'`from_php.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-from_php.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-from_php.Tpo -c from_php.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-from_php.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-from_php.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-from_php.Tpo -c from_php.c -o lib_mysqludf_preg_la-from_php.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-from_php.Tpo .deps/lib_mysqludf_preg_la-from_php.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_capture.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.Tpo -c -o lib_mysqludf_preg_la-lib_mysqludf_preg_capture.lo `test -f 'lib_mysqludf_preg_capture.c' || echo './'`lib_mysqludf_preg_capture.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_capture.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.Tpo -c lib_mysqludf_preg_capture.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_capture.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.Tpo -c lib_mysqludf_preg_capture.c -o lib_mysqludf_preg_la-lib_mysqludf_preg_capture.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.Tpo .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_check.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_check.Tpo -c -o lib_mysqludf_preg_la-lib_mysqludf_preg_check.lo `test -f 'lib_mysqludf_preg_check.c' || echo './'`lib_mysqludf_preg_check.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_check.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_check.Tpo -c lib_mysqludf_preg_check.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_check.o
lib_mysqludf_preg_check.c: In function ‘preg_check’:
lib_mysqludf_preg_check.c:174:9: warning: return makes integer from pointer without a cast [enabled by default]
         return NULL ;
         ^
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_check.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_check.Tpo -c lib_mysqludf_preg_check.c -o lib_mysqludf_preg_la-lib_mysqludf_preg_check.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_check.Tpo .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_check.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_info.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_info.Tpo -c -o lib_mysqludf_preg_la-lib_mysqludf_preg_info.lo `test -f 'lib_mysqludf_preg_info.c' || echo './'`lib_mysqludf_preg_info.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_info.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_info.Tpo -c lib_mysqludf_preg_info.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_info.o
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_info.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_info.Tpo -c lib_mysqludf_preg_info.c -o lib_mysqludf_preg_la-lib_mysqludf_preg_info.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_info.Tpo .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_info.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_position.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_position.Tpo -c -o lib_mysqludf_preg_la-lib_mysqludf_preg_position.lo `test -f 'lib_mysqludf_preg_position.c' || echo './'`lib_mysqludf_preg_position.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_position.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_position.Tpo -c lib_mysqludf_preg_position.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_position.o
lib_mysqludf_preg_position.c: In function ‘preg_position’:
lib_mysqludf_preg_position.c:218:9: warning: return makes integer from pointer without a cast [enabled by default]
         return NULL ;
         ^
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_position.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_position.Tpo -c lib_mysqludf_preg_position.c -o lib_mysqludf_preg_la-lib_mysqludf_preg_position.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_position.Tpo .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_position.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_replace.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.Tpo -c -o lib_mysqludf_preg_la-lib_mysqludf_preg_replace.lo `test -f 'lib_mysqludf_preg_replace.c' || echo './'`lib_mysqludf_preg_replace.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_replace.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.Tpo -c lib_mysqludf_preg_replace.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.o
lib_mysqludf_preg_replace.c: In function ‘preg_replace’:
lib_mysqludf_preg_replace.c:298:26: warning: comparison between pointer and integer [enabled by default]
         if (!s && msg[0] != NULL) {
                          ^
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_replace.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.Tpo -c lib_mysqludf_preg_replace.c -o lib_mysqludf_preg_la-lib_mysqludf_preg_replace.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.Tpo .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.Plo
/bin/sh ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.    -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.Tpo -c -o lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.lo `test -f 'lib_mysqludf_preg_rlike.c' || echo './'`lib_mysqludf_preg_rlike.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.Tpo -c lib_mysqludf_preg_rlike.c  -fPIC -DPIC -o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.o
lib_mysqludf_preg_rlike.c: In function ‘preg_rlike’:
lib_mysqludf_preg_rlike.c:179:13: warning: return makes integer from pointer without a cast [enabled by default]
             return NULL ;
             ^
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql -I yes -g -O2 -MT lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.lo -MD -MP -MF .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.Tpo -c lib_mysqludf_preg_rlike.c -o lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.o >/dev/null 2>&1
mv -f .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.Tpo .deps/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.Plo
/bin/sh ./libtool  --tag=CC   --mode=link gcc -DSTANDARD -DMYSQL_SERVER -I/usr/include/mysql  -I yes    -g -O2 -module -avoid-version -lpcre -lpthread  -o lib_mysqludf_preg.la -rpath /usr/lib64/mysql/plugin lib_mysqludf_preg_la-preg.lo lib_mysqludf_preg_la-preg_utils.lo lib_mysqludf_preg_la-ghmysql.lo lib_mysqludf_preg_la-ghfcns.lo lib_mysqludf_preg_la-from_php.lo lib_mysqludf_preg_la-lib_mysqludf_preg_capture.lo lib_mysqludf_preg_la-lib_mysqludf_preg_check.lo lib_mysqludf_preg_la-lib_mysqludf_preg_info.lo lib_mysqludf_preg_la-lib_mysqludf_preg_position.lo lib_mysqludf_preg_la-lib_mysqludf_preg_replace.lo lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.lo
libtool: link: gcc -shared  -fPIC -DPIC  .libs/lib_mysqludf_preg_la-preg.o .libs/lib_mysqludf_preg_la-preg_utils.o .libs/lib_mysqludf_preg_la-ghmysql.o .libs/lib_mysqludf_preg_la-ghfcns.o .libs/lib_mysqludf_preg_la-from_php.o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_capture.o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_check.o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_info.o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_position.o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_replace.o .libs/lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.o   -lpcre -lpthread  -O2   -Wl,-soname -Wl,lib_mysqludf_preg.so -o .libs/lib_mysqludf_preg.so
libtool: link: ar cru .libs/lib_mysqludf_preg.a  lib_mysqludf_preg_la-preg.o lib_mysqludf_preg_la-preg_utils.o lib_mysqludf_preg_la-ghmysql.o lib_mysqludf_preg_la-ghfcns.o lib_mysqludf_preg_la-from_php.o lib_mysqludf_preg_la-lib_mysqludf_preg_capture.o lib_mysqludf_preg_la-lib_mysqludf_preg_check.o lib_mysqludf_preg_la-lib_mysqludf_preg_info.o lib_mysqludf_preg_la-lib_mysqludf_preg_position.o lib_mysqludf_preg_la-lib_mysqludf_preg_replace.o lib_mysqludf_preg_la-lib_mysqludf_preg_rlike.o
libtool: link: ranlib .libs/lib_mysqludf_preg.a
libtool: link: ( cd ".libs" && rm -f "lib_mysqludf_preg.la" && ln -s "../lib_mysqludf_preg.la" "lib_mysqludf_preg.la" )
make[2]: Leaving directory `/lib_mysqludf_preg'
make[1]: Leaving directory `/lib_mysqludf_preg'
Making install in test
make[1]: Entering directory `/lib_mysqludf_preg/test'
make[2]: Entering directory `/lib_mysqludf_preg'
make[2]: Leaving directory `/lib_mysqludf_preg'
make[2]: Entering directory `/lib_mysqludf_preg/test'
make[3]: Entering directory `/lib_mysqludf_preg'
make[3]: Leaving directory `/lib_mysqludf_preg'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/lib_mysqludf_preg/test'
make[1]: Leaving directory `/lib_mysqludf_preg/test'
Making install in doc
make[1]: Entering directory `/lib_mysqludf_preg/doc'
make[2]: Entering directory `/lib_mysqludf_preg'
make[2]: Leaving directory `/lib_mysqludf_preg'
make[2]: Entering directory `/lib_mysqludf_preg/doc'
make[3]: Entering directory `/lib_mysqludf_preg'
make[3]: Leaving directory `/lib_mysqludf_preg'
make[2]: Nothing to be done for `install-exec-am'.
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/lib_mysqludf_preg/doc'
make[1]: Leaving directory `/lib_mysqludf_preg/doc'
make[1]: Entering directory `/lib_mysqludf_preg'
make[2]: Entering directory `/lib_mysqludf_preg'
 /usr/bin/mkdir -p '/usr/lib64/mysql/plugin'
 /bin/sh ./libtool   --mode=install /usr/bin/install -c   lib_mysqludf_preg.la '/usr/lib64/mysql/plugin'
libtool: install: /usr/bin/install -c .libs/lib_mysqludf_preg.so /usr/lib64/mysql/plugin/lib_mysqludf_preg.so
libtool: install: /usr/bin/install -c .libs/lib_mysqludf_preg.lai /usr/lib64/mysql/plugin/lib_mysqludf_preg.la
libtool: install: /usr/bin/install -c .libs/lib_mysqludf_preg.a /usr/lib64/mysql/plugin/lib_mysqludf_preg.a
libtool: install: chmod 644 /usr/lib64/mysql/plugin/lib_mysqludf_preg.a
libtool: install: ranlib /usr/lib64/mysql/plugin/lib_mysqludf_preg.a
libtool: finish: PATH="/sbin:/bin:/usr/sbin:/usr/bin:/sbin" ldconfig -n /usr/lib64/mysql/plugin
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/lib64/mysql/plugin

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the `-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the `LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the `LD_RUN_PATH' environment variable
     during linking
   - use the `-Wl,-rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to `/etc/ld.so.conf'

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
make[2]: Nothing to be done for `install-data-am'.
make[2]: Leaving directory `/lib_mysqludf_preg'
make[1]: Leaving directory `/lib_mysqludf_preg'
/
Shutting down MySQL.. SUCCESS!
Starting MySQL.170611 16:59:58 mysqld_safe Logging to '/var/lib/mysql/galera-1.edc.renci.org.err'.
170611 16:59:58 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
 SUCCESS!
Updating /var/lib/irods/VERSION.json...
The iRODS service account name needs to be defined.
iRODS user [irods]:
iRODS group [irods]:

+--------------------------------+
| Setting up the service account |
+--------------------------------+

Existing Group Detected: irods
Existing Account Detected: irods
Setting owner of /var/lib/irods to irods:irods
Setting owner of /etc/irods to irods:irods
iRODS server's role:
1. provider
2. consumer
Please select a number or choose 0 to enter a new value [1]:
Updating /etc/irods/server_config.json...

+-----------------------------------------+
| Configuring the database communications |
+-----------------------------------------+

You are configuring an iRODS database plugin. The iRODS server cannot be started until its database has been properly configured.

ODBC driver for mysql:
1. MySQL
2. MySQL ODBC 5.3 Unicode Driver
3. MySQL ODBC 5.3 ANSI Driver
Please select a number or choose 0 to enter a new value [1]:
Database server's hostname or IP address [localhost]:
Database server's port [3306]:
Database name [ICAT]:
Database username [irods]:

-------------------------------------------
Database Type: mysql
ODBC Driver:   MySQL ODBC 5.3 Unicode Driver
Database Host: localhost
Database Port: 3306
Database Name: ICAT
Database User: irods
-------------------------------------------

Please confirm [yes]:

Updating /etc/irods/server_config.json...
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.
Listing database tables...
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.

Updating /etc/irods/server_config.json...

+--------------------------------+
| Configuring the server options |
+--------------------------------+

iRODS server's zone name [tempZone]:
iRODS server's port [1247]:
iRODS port range (begin) [20000]:
iRODS port range (end) [20199]:
Control Plane port [1248]:
Schema Validation Base URI (or off) [file:///var/lib/irods/configuration_schemas]:
iRODS server's administrator username [rods]:

-------------------------------------------
Zone name:                  tempZone
iRODS server port:          1247
iRODS port range (begin):   20000
iRODS port range (end):     20199
Control plane port:         1248
Schema validation base URI: file:///var/lib/irods/configuration_schemas
iRODS server administrator: rods
-------------------------------------------

Please confirm [yes]: Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.




Updating /etc/irods/server_config.json...

+-----------------------------------+
| Setting up the client environment |
+-----------------------------------+

Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.
Warning: Cannot control echo output on the terminal (stdin is not a tty). Input may be echoed.



Updating /var/lib/irods/.irods/irods_environment.json...

+--------------------------+
| Setting up default vault |
+--------------------------+

iRODS Vault directory [/var/lib/irods/Vault]:

+-------------------------+
| Setting up the database |
+-------------------------+

Listing database tables...
Defining mysql functions...
Creating database tables...

+-------------------+
| Starting iRODS... |
+-------------------+

Validating [/var/lib/irods/.irods/irods_environment.json]... Success
Validating [/var/lib/irods/VERSION.json]... Success
Validating [/etc/irods/server_config.json]... Success
Validating [/etc/irods/host_access_control_config.json]... Success
Validating [/etc/irods/hosts_config.json]... Success
Ensuring catalog schema is up-to-date...
Updating to schema version 2...
Updating to schema version 3...
Updating to schema version 4...
Updating to schema version 5...
Catalog schema is up-to-date.
Starting iRODS server...
Success

+---------------------+
| Attempting test put |
+---------------------+

Putting the test file into iRODS...
Getting the test file from iRODS...
Removing the test file from iRODS...
Success.

+--------------------------------+
| iRODS is installed and running |
+--------------------------------+

Shutting down MySQL... SUCCESS!
set /etc/my.cnf.d/server.cnf
$ cat /etc/my.cnf.d/server.cnf
[galera]
# Mandatory settings
wsrep_on=ON
wsrep_provider=/usr/lib64/galera/libgalera_smm.so
wsrep_provider_options='evs.keepalive_period=PT3S;evs.suspect_timeout=PT30S;evs.inactive_timeout=PT1M;evs.install_timeout=PT1M;evs.join_retrans_period=PT1.5S'
wsrep_cluster_address='gcomm://172.25.8.171,172.25.8.172,172.25.8.173'
wsrep_cluster_name='galera'
wsrep_node_address='172.25.8.171'
wsrep_node_name='galera-1'
wsrep_sst_method=rsync

binlog_format=row
default_storage_engine=InnoDB
innodb_autoinc_lock_mode=2
bind-address=0.0.0.0
Starting MySQL.170611 17:00:04 mysqld_safe Logging to '/var/lib/mysql/galera-1.edc.renci.org.err'.
170611 17:00:05 mysqld_safe Starting mysqld daemon with databases from /var/lib/mysql
. SUCCESS!
[MySQL]> SHOW VARIABLES LIKE 'wsrep%';
Variable_name	Value
wsrep_osu_method	TOI
wsrep_auto_increment_control	ON
wsrep_causal_reads	OFF
wsrep_certify_nonpk	ON
wsrep_cluster_address	gcomm://172.25.8.171,172.25.8.172,172.25.8.173
wsrep_cluster_name	galera
wsrep_convert_lock_to_trx	OFF
wsrep_data_home_dir	/var/lib/mysql/
wsrep_dbug_option
wsrep_debug	OFF
wsrep_desync	OFF
wsrep_dirty_reads	OFF
wsrep_drupal_282555_workaround	OFF
wsrep_forced_binlog_format	NONE
wsrep_gtid_domain_id	0
wsrep_gtid_mode	OFF
wsrep_load_data_splitting	ON
wsrep_log_conflicts	OFF
wsrep_max_ws_rows	0
wsrep_max_ws_size	2147483647
wsrep_mysql_replication_bundle	0
wsrep_node_address	172.25.8.171
wsrep_node_incoming_address	AUTO
wsrep_node_name	galera-1
wsrep_notify_cmd
wsrep_on	ON
wsrep_patch_version	wsrep_25.19
wsrep_provider	/usr/lib64/galera/libgalera_smm.so
wsrep_provider_options	base_dir = /var/lib/mysql/; base_host = 172.25.8.171;
base_port = 4567; cert.log_conflicts = no; debug = no; evs.auto_evict = 0;
evs.causal_keepalive_period = PT3S; evs.debug_log_mask = 0x1; evs.delay_margin
= PT1S; evs.delayed_keep_period = PT30S; evs.inactive_check_period = PT0.5S;
evs.inactive_timeout = PT1M; evs.info_log_mask = 0; evs.install_timeout = PT1M;
evs.join_retrans_period = PT1.5S; evs.keepalive_period = PT3S;
evs.max_install_timeouts = 3; evs.send_window = 4; evs.stats_report_period =
PT1M; evs.suspect_timeout = PT30S; evs.use_aggregate = true;
evs.user_send_window = 2; evs.version = 0; evs.view_forget_timeout = P1D;
gcache.dir = /var/lib/mysql/; gcache.keep_pages_size = 0; gcache.mem_size = 0;
gcache.name = /var/lib/mysql//galera.cache; gcache.page_size = 128M;
gcache.recover = no; gcache.size = 128M; gcomm.thread_prio = ; gcs.fc_debug =
0; gcs.fc_factor = 1.0; gcs.fc_limit = 16; gcs.fc_master_slave = no;
gcs.max_packet_size = 64500; gcs.max_throttle = 0.25; gcs.recv_q_hard_limit =
9223372036854775807; gcs.recv_q_soft_limit = 0.25; gcs.sync_donor = no;
gmcast.listen_addr = tcp://0.0.0.0:4567; gmcast.mcast_addr = ; gmcast.mcast_ttl
= 1; gmcast.peer_timeout = PT3S; gmcast.segment = 0; gmcast.time_wait = PT5S;
gmcast.version = 0; ist.recv_addr = 172.25.8.171; pc.announce_timeout = PT3S;
pc.checksum = false; pc.ignore_quorum = false; pc.ignore_sb = false; pc.linger
= PT20S; pc.npvo = false; pc.recovery = true; pc.version = 0; pc.wait_prim =
true; pc.wait_prim_timeout = PT30S; pc.weight = 1; protonet.backend = asio;
protonet.version = 0; repl.causal_read_timeout = PT30S; repl.commit_order = 3;
repl.key_format = FLAT8; repl.max_ws_size = 2147483647; repl.proto_max = 7;
socket.checksum = 2; socket.recv_buf_size = 212992;
wsrep_recover	OFF
wsrep_replicate_myisam	OFF
wsrep_restart_slave	OFF
wsrep_retry_autocommit	1
wsrep_slave_fk_checks	ON
wsrep_slave_uk_checks	OFF
wsrep_slave_threads	1
wsrep_sst_auth
wsrep_sst_donor
wsrep_sst_donor_rejects_queries	OFF
wsrep_sst_method	rsync
wsrep_sst_receive_address	AUTO
wsrep_start_position	00000000-0000-0000-0000-000000000000:-1
wsrep_sync_wait	0
$ ss -lntu
Netid  State      Recv-Q Send-Q Local Address:Port               Peer Address:Port
tcp    LISTEN     0      100       *:1248                  *:*
tcp    LISTEN     0      80        *:3306                  *:*
tcp    LISTEN     0      128       *:4567                  *:*
tcp    LISTEN     0      50        *:1247                  *:*
usermod: no changes
usermod: no changes
```
