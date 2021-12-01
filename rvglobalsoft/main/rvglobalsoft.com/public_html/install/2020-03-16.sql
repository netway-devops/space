REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('EnableAutoRenewService', 'on');
##########
UPDATE hb_common c
LEFT JOIN hb_prices pms ON pms.type='m_setup' AND pms.rel_id=c.id AND pms.rel=c.rel
LEFT JOIN hb_prices pqs ON pqs.type='q_setup' AND pqs.rel_id=c.id AND pqs.rel=c.rel
LEFT JOIN hb_prices pss ON pss.type='s_setup' AND pss.rel_id=c.id AND pss.rel=c.rel
LEFT JOIN hb_prices pas ON pas.type='a_setup' AND pas.rel_id=c.id AND pas.rel=c.rel
LEFT JOIN hb_prices pbs ON pbs.type='b_setup' AND pbs.rel_id=c.id AND pbs.rel=c.rel
LEFT JOIN hb_prices pts ON pts.type='t_setup' AND pts.rel_id=c.id AND pts.rel=c.rel
LEFT JOIN hb_prices pds ON pds.type='d_setup' AND pds.rel_id=c.id AND pds.rel=c.rel
LEFT JOIN hb_prices pws ON pws.type='w_setup' AND pws.rel_id=c.id AND pws.rel=c.rel
LEFT JOIN hb_prices phs ON phs.type='h_setup' AND phs.rel_id=c.id AND phs.rel=c.rel
LEFT JOIN hb_prices pp4s ON pp4s.type='p4_setup' AND pp4s.rel_id=c.id AND pp4s.rel=c.rel
LEFT JOIN hb_prices pp5s ON pp5s.type='p5_setup' AND pp5s.rel_id=c.id AND pp5s.rel=c.rel
LEFT JOIN hb_prices pm ON pm.type='m' AND pm.rel_id=c.id AND pm.rel=c.rel
LEFT JOIN hb_prices pq ON pq.type='q' AND pq.rel_id=c.id AND pq.rel=c.rel
LEFT JOIN hb_prices ps ON ps.type='s' AND ps.rel_id=c.id AND ps.rel=c.rel
LEFT JOIN hb_prices pa ON pa.type='a' AND pa.rel_id=c.id AND pa.rel=c.rel
LEFT JOIN hb_prices pb ON pb.type='b' AND pb.rel_id=c.id AND pb.rel=c.rel
LEFT JOIN hb_prices pt ON pt.type='t' AND pt.rel_id=c.id AND pt.rel=c.rel
LEFT JOIN hb_prices pd ON pd.type='d' AND pd.rel_id=c.id AND pd.rel=c.rel
LEFT JOIN hb_prices pw ON pw.type='w' AND pw.rel_id=c.id AND pw.rel=c.rel
LEFT JOIN hb_prices ph ON ph.type='h' AND ph.rel_id=c.id AND ph.rel=c.rel
LEFT JOIN hb_prices pp4 ON pp4.type='p4' AND pp4.rel_id=c.id AND pp4.rel=c.rel
LEFT JOIN hb_prices pp5 ON pp5.type='p5' AND pp5.rel_id=c.id AND pp5.rel=c.rel
SET c.m_setup = COALESCE(pms.price, c.m_setup),
c.q_setup = COALESCE(pqs.price, c.q_setup),
c.s_setup = COALESCE(pss.price, c.s_setup),
c.a_setup = COALESCE(pas.price, c.a_setup),
c.b_setup = COALESCE(pbs.price, c.b_setup),
c.t_setup = COALESCE(pts.price, c.t_setup),
c.d_setup = COALESCE(pds.price, c.d_setup),
c.w_setup = COALESCE(pws.price, c.w_setup),
c.h_setup = COALESCE(phs.price, c.h_setup),
c.p4_setup = COALESCE(pp4s.price, c.p4_setup),
c.p5_setup = COALESCE(pp5s.price, c.p5_setup),
c.m = COALESCE(pm.price, c.m),
c.q = COALESCE(pq.price, c.q),
c.s = COALESCE(ps.price, c.s),
c.a = COALESCE(pa.price, c.a),
c.b = COALESCE(pb.price, c.b),
c.t = COALESCE(pt.price, c.t),
c.d = COALESCE(pd.price, c.d),
c.w = COALESCE(pw.price, c.w),
c.h = COALESCE(ph.price, c.h),
c.p4 = COALESCE(pp4.price, c.p4),
c.p5 = COALESCE(pp5.price, c.p5);