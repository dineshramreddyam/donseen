output "pub_sub_ids" {
    value = aws_subnet.public.*.id
}
output "pri_sub_ids" {
    value = local.pri_sub_ids
}
output "vpc_id" {
    value = aws_vpc.main.id
}  
   